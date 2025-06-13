


import SwiftUI
struct InvoiceView: View {
    @Binding var path: NavigationPath
    let total : Double
    let fee: Int
    let location: String
    let phone: String
    @State private var orderFees: Double = 0.0

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

            HStack {
                Text("Discount Code:")
                    .font(.system(size: 18, weight: .medium))

                Spacer()

                TextField("Enter Code", text: $viewModel.discountCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 120)
                    .foregroundColor(.blue)

                Button(action: {
                    print("Verify discount code: \(viewModel.discountCode)")
                    let subtotal = calculateCartSubtotalValue()

                    if viewModel.discountCode == "summer25" {
                        let discount = subtotal * 0.25
                        orderFees = (subtotal - discount) + Double(fee)
                    } else {
                        orderFees = subtotal + Double(fee)
                    }
                }) {
                    Text("Apply")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 15)

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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let subtotal = calculateCartSubtotalValue()
                orderFees = subtotal + Double(fee)
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

