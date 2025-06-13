


import SwiftUI
struct InvoiceView: View {
    @Binding var path: NavigationPath
    let total : Double
    let fee: Int
    let location: String
    let phone: String
    @State private var orderFees: Double = 0.0
    @State private var discountMessage = ""
    @State private var isCodeApplied = false
    @State private var discount: Double = 0.0
    
    
    
    
    @StateObject var viewModel = CartViewModel(cartUsecase: CartUsecase())
    
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
                Text("Cart subtotal:")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Text("\(calculateCartSubtotal()) \(viewModel.cartLines.first?.currency ?? "")")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            HStack {
                Text("Delivery Fee:")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Text("\(fee) \(viewModel.cartLines.first?.currency ?? "")")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack(spacing: 10) {
                    Text("Discount Code:")
                        .font(.system(size: 18, weight: .medium))
                    Spacer()
                    
                    TextField("Enter Code", text: $viewModel.discountCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 120)
                        .foregroundColor(.blue)
                    //    Spacer()
                    Button(action: {
                        if isCodeApplied {
                            let subtotal = calculateCartSubtotalValue()
                            orderFees = subtotal + Double(fee)
                            discountMessage = ""
                            viewModel.discountCode = ""
                            isCodeApplied = false
                        } else {
                            
                            print("Verify discount code: \(viewModel.discountCode)")
                            let subtotal = calculateCartSubtotalValue()
                            let code = viewModel.discountCode.uppercased()
                            var saved: Double = 0
                            
                            if code == "SUMMER15" {
                                discount = subtotal * 0.15
                                orderFees = (subtotal - discount) + Double(fee)
                                saved = discount
                                discountMessage = String(format: "You saved %.2f \(viewModel.cartLines.first?.currency ?? "")", saved)
                                isCodeApplied = true
                            }
                            else if code == "SUMMER10" {
                                discount = subtotal * 0.10
                                orderFees = (subtotal - discount) + Double(fee)
                                saved = discount
                                discountMessage = String(format: "You saved %.2f \(viewModel.cartLines.first?.currency ?? "")", saved)
                                isCodeApplied = true
                            }
                            else if code == "WELCOME50" {
                                discount = 50.0
                                orderFees = (subtotal - discount) + Double(fee)
                                saved = discount
                                discountMessage = String(format: "You saved %.2f \(viewModel.cartLines.first?.currency ?? "")", saved)
                                isCodeApplied = true
                            }
                            else {
                                orderFees = subtotal + Double(fee)
                                discountMessage = "Coupon not valid"
                                isCodeApplied = false
                            }
                        }
                    }) {
                        Text(isCodeApplied ? "Remove" : "Apply")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                            .background(isCodeApplied ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }.padding(.horizontal, 15)
                
                if !discountMessage.isEmpty {
                    Text(discountMessage)
                        .font(.footnote)
                        .foregroundColor(discountMessage.contains("saved") ? .green : .red)
                        .padding(.top, 4)
                        .padding(.horizontal , 15)
                }
            }
            
            
            HStack {
                Text("Total:")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Text(String(format: "%.2f", orderFees) + " \(viewModel.cartLines.first?.currency ?? "")")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            HStack {
                Text("Location:")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Text(location)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            HStack {
                Text("Phone:")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Text(phone)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            .padding(.vertical, 15)
            
            Button("Place Order") {
                path.append(AppRouter.paymentMethods(orderFees: orderFees))
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let subtotal = calculateCartSubtotalValue()
                orderFees = isCodeApplied
                ? subtotal + Double(fee) - discount
                : subtotal + Double(fee)
            }
        }
    }
        
        func calculateCartSubtotal() -> String {
            let total = calculateCartSubtotalValue()
            return String(format: "%.2f", total)
        }
        
        func calculateCartSubtotalValue() -> Double {
            let total = viewModel.cartLines.reduce(Decimal(0)) { result, line in
                result + line.price
            }
            return NSDecimalNumber(decimal: total).doubleValue
        }
    }
    

