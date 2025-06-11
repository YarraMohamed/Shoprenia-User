//
//  CartView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI
import MobileBuySDK

struct CartView: View {
    @Binding var path: NavigationPath
    @StateObject var viewModel = CartViewModel(cartUsecase: CartUsecase())
    @State var showAlert: Bool = false
    @State var lineIdToDelete: String?

    var body: some View {
        VStack {
            Text("\(viewModel.cartLines.count) Items")
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                .padding(.top)

            if viewModel.cart != nil {
                List {
                    ForEach(viewModel.cartLines) { line in
                        CartProductView(
                            line: line,
                            onIncrease: {
                                viewModel.updateCartQuantity(
                                    lineId: line.id,
                                    newQuantity: line.quantity + 1
                                )
                            },
                            onDecrease: {
                                if line.quantity > 1 {
                                    viewModel.updateCartQuantity(
                                        lineId: line.id,
                                        newQuantity: line.quantity - 1
                                    )
                                } else {
                                    lineIdToDelete = line.id
                                    showAlert = true
                                }
                            },
                            onDelete: {
                                   lineIdToDelete = line.id
                                
                                   showAlert = true
                               }
                            
                        )
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.bottom, 20)

                Text("Total is: \(calculateTotal()) \(viewModel.cartLines.first?.currency ?? "")")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)

                Button("Get Them") {
                    path.append(AppRouter.shippingAddresses)
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 250, height: 48)
                .background {
                    RoundedRectangle(cornerRadius: 30).fill(.blue)
                }
            } else {
                ProgressView("Loading Cart...")
            }
        }
        .onAppear {
            viewModel.fetchCart()
        }
        .alert("Are you sure to delete this item?", isPresented: $showAlert) {
            Button("No", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if let lineId = lineIdToDelete {
                    viewModel.removeFromCart(lineId: lineId)
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("Cart")
    }

    func calculateTotal() -> String {
        let total = viewModel.cartLines.reduce(Decimal(0)) { result, line in
            result + line.price
        }

        let doubleTotal = NSDecimalNumber(decimal: total).doubleValue
        return String(format: "%.2f", doubleTotal)
    }

}
