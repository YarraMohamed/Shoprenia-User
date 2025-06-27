import SwiftUI
import Kingfisher
import MobileBuySDK

struct WishlistRow: View {
    var product : FirestoreShopifyProduct
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Binding var path : NavigationPath
    @State private var convertedPrice: Double? = nil
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"
    var body: some View {
        HStack{
            KFImage(URL(string: product.imageUrl))
                .resizable()
                .placeholder{
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(width: 133,height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            VStack{
                Text(product.title)
                    .font(.system(size: 16,weight: .semibold))
                
                Text(product.brand)
                    .font(.system(size: 12,weight: .semibold))
                    .foregroundStyle(.gray)
                    .padding(.vertical,3)
                
                Text(
                    selectedCurrency == "USD"
                     ? "USD \(String(format: "%.2f", convertedPrice ?? 0))"
                    : "EGP \(String(describing: product.price))"
                 )
                //Text("\(product.currencyName) \(product.price)")
                    .font(.system(size: 12,weight: .semibold))
                    .foregroundStyle(.blue)
                
                HStack{
                    Button("See all buying options"){
                        path.append(AppRouter.productDetails(productId: product.id))
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 200, height: 30)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.blue)
                    }
                    
                }
            }
            
        }
        .onAppear{
            if selectedCurrency == "USD" {
                let priceEGP = Double(product.price) ?? 0.0
                let priceDouble = NSDecimalNumber(decimal: Decimal(priceEGP)).doubleValue
                convertedPrice = convertEGPToUSD(priceDouble)
            }
        }

        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "EAEFEF"))
        )
    }
    
    private func convertEGPToUSD(_ amount: Double) -> Double {
        let exchangeRate: Double = 1.0 / 49.71
        let result = amount * exchangeRate
        return Double(round(100 * result) / 100)
    }
}

#Preview {
    WishlistRow(product: FirestoreShopifyProduct(id: "1", title: "VANS |AUTHENTIC | LO PRO | BURGANDY/WHITE", brand: "Vans", price: "29", imageUrl: "https://cdn.shopify.com/s/files/1/0648/0714/1450/files/product_1_image1.jpg?v=1748169351",currencyName: "egp"), path: .constant(NavigationPath()))
}
