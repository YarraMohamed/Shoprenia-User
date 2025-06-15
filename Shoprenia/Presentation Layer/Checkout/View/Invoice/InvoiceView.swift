//
//  InvoiceItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 10/06/2025.
//

import SwiftUI

struct InvoiceView: View {
    @Binding var path: NavigationPath
    let total: Double
    let fee: Int
    let location: String
    let phone: String
    
    @State private var discountAmount: Double = 0.0
    @State private var orderFees: Double = 0.0
    @State private var discountMessage = ""
    @State private var isCodeApplied = false
    @State private var discount: Double = 0.0
    
    @StateObject var viewModel = CartViewModel(cartUsecase: CartUsecase())
    
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"
    
    let rows: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 10) {
                    ForEach(viewModel.cartLines) { line in
                        InvoiceItem(line: line)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, maxHeight: 250)
            
            HStack {
                Text("Subtotal:")
                Spacer()
                Text("\(String(format: "%.2f", calculateCartSubtotalConverted())) \(selectedCurrency)")
                    .foregroundColor(.blue)
            }
            .font(.system(size: 18, weight: .medium))
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            HStack {
                Text("Delivery Fee:")
                Spacer()
                Text("\(String(format: "%.2f", convertAmountIfNeeded(Double(fee)))) \(selectedCurrency)")
                    .foregroundColor(.blue)
            }
            .font(.system(size: 18, weight: .medium))
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Text("Discount Code:")
                    Spacer()
                    
                    TextField("Enter Code", text: $viewModel.discountCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 120)
                        .foregroundColor(.blue)
                    
                    Button(action: applyDiscountCode) {
                        Text(isCodeApplied ? "Remove" : "Apply")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(isCodeApplied ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal, 15)
                
                if !discountMessage.isEmpty {
                    Text(discountMessage)
                        .font(.footnote)
                        .foregroundColor(discountMessage.contains("saved") ? .green : .red)
                        .padding(.top, 4)
                        .padding(.horizontal, 15)
                }
            }
            
            HStack {
                Text("Total:")
                Spacer()
                Text(String(format: "%.2f", orderFees) + " \(selectedCurrency)")
                    .foregroundColor(.blue)
            }
            .font(.system(size: 18, weight: .medium))
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            HStack {
                Text("Location:")
                Spacer()
                Text(location)
                    .foregroundColor(.blue)
            }
            .font(.system(size: 18, weight: .medium))
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            HStack {
                Text("Phone:")
                Spacer()
                Text(phone)
                    .foregroundColor(.blue)
            }
            .font(.system(size: 18, weight: .medium))
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            Button("Place Order") {
                path.append(AppRouter.paymentMethods(orderFees: orderFees, shipping: Int(convertAmountIfNeeded(Double(fee))), code: viewModel.discountCode, discount: discountAmount))
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 40)
            
            Spacer()
        }
        .navigationTitle("Invoice")
        .onAppear {
            viewModel.fetchCart()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                updateOrderFees()
            }
        }
    }
    
    // MARK: - Conversion Helpers
    
    private func convertEGPToUSD(_ amount: Double) -> Double {
        let exchangeRate: Double = 1.0 / 49.71
        return amount * exchangeRate
    }
    
    private func convertAmountIfNeeded(_ amount: Double) -> Double {
        return selectedCurrency == "USD" ? convertEGPToUSD(amount) : amount
    }
    
    private func calculateCartSubtotalValue() -> Double {
        let total = viewModel.cartLines.reduce(Decimal(0)) { result, line in
            result + line.price
        }
        return NSDecimalNumber(decimal: total).doubleValue
    }
    
    private func calculateCartSubtotalConverted() -> Double {
        let subtotal = calculateCartSubtotalValue()
        return convertAmountIfNeeded(subtotal)
    }
    
    // MARK: - Discount
    
    private func applyDiscountCode() {
        let subtotal = calculateCartSubtotalValue()
        var saved: Double = 0
        let code = viewModel.discountCode.uppercased()
        
        if isCodeApplied {
            orderFees = convertAmountIfNeeded(subtotal + Double(fee))
            viewModel.discountCode = ""
            discountMessage = ""
            discountAmount = 0
            discount = 0
            isCodeApplied = false
            return
        }
        
        if code == "SUMMER15" {
            discountAmount = 0.15
            discount = subtotal * 0.15
        } else if code == "SUMMER10" {
            discountAmount = 0.10
            discount = subtotal * 0.10
        } else if code == "WELCOME50" {
            discountAmount = 50.0
            discount = 50.0
        } else {
            orderFees = convertAmountIfNeeded(subtotal + Double(fee))
            discountMessage = "Coupon not valid"
            isCodeApplied = false
            return
        }
        
        saved = discount
        orderFees = convertAmountIfNeeded((subtotal - discount) + Double(fee))
        discountMessage = String(format: "You saved %.2f \(selectedCurrency)", convertAmountIfNeeded(saved))
        isCodeApplied = true
    }
    
    private func updateOrderFees() {
        let subtotal = calculateCartSubtotalValue()
        orderFees = isCodeApplied
            ? convertAmountIfNeeded((subtotal - discount) + Double(fee))
            : convertAmountIfNeeded(subtotal + Double(fee))
    }
}
