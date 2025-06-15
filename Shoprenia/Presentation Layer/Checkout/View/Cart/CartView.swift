
import SwiftUI
import MobileBuySDK

struct CartView: View {
    @Binding var path: NavigationPath
    @StateObject var viewModel = CartViewModel(cartUsecase: CartUsecase())
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"
    @State var showAlert: Bool = false
    @State var lineIdToDelete: String?
    @State var showNotAvailableAlert: Bool = false

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
                            onIncrease: { handleIncrease(line: line) },
                            onDecrease: { handleDecrease(line: line) },
                            onDelete: { handleDelete(line: line) },
                            onTap: {
                                path.append(AppRouter.productDetails(productId: line.productId))
                            }
                        )
                    
                    }
                }
        
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .padding(.bottom, 20)

                Text( selectedCurrency == "USD" ?
                    "Total is: \(calculateTotal()) USD"
                    : "Total is: \(calculateTotal()) EGP"
                )
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)

                if viewModel.cartLines.count > 0 {
                    Button("Get Them") {
                        path.append(AppRouter.shippingAddresses)
                    }
                    
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 250, height: 48)
                    .background {
                        RoundedRectangle(cornerRadius: 30).fill(.blue)
                    }
                }
                  
                   
                
            } else {
                ProgressView("Loading Cart...")
            }
        }
        .alert("You've reached the limit for this product.", isPresented: $showNotAvailableAlert) {
            Button("OK", role: .cancel) { }
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
        var doubleTotal = NSDecimalNumber(decimal: total).doubleValue
        if selectedCurrency == "USD"{
           doubleTotal = convertEGPToUSD(doubleTotal)
        }
        return String(format: "%.2f", doubleTotal)
    }

    func handleIncrease( line: CartLineItem) {
        if line.quantity < 5 {
            viewModel.checkVariantAvailability(variantId: line.variantId)
            let isAvailable = viewModel.isVariantAvailable
            if isAvailable ?? false {
                viewModel.updateCartQuantity(lineId: line.id, newQuantity: line.quantity + 1)
            } else {
                showNotAvailableAlert = true
            }
        } else {
            showNotAvailableAlert = true
        }
    }

    func handleDecrease( line: CartLineItem) {
        if line.quantity > 1 {
            viewModel.updateCartQuantity(lineId: line.id, newQuantity: line.quantity - 1)
        } else {
            lineIdToDelete = line.id
            showAlert = true
        }
    }

    func handleDelete( line: CartLineItem) {
        lineIdToDelete = line.id
        showAlert = true
    }

    private func convertEGPToUSD(_ amount: Double) -> Double {
        let exchangeRate: Double = 1.0 / 49.71
        return amount * exchangeRate
    }
}
