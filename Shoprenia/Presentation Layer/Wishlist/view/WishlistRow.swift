import SwiftUI
import Kingfisher
import MobileBuySDK

struct WishlistRow: View {
    var product : FirestoreShopifyProduct
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @Binding var path : NavigationPath
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
                
                Text("\(product.currencyName) \(product.price)")
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
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "EAEFEF"))
        )
    }
}

#Preview {
    WishlistRow(product: FirestoreShopifyProduct(id: "1", title: "VANS |AUTHENTIC | LO PRO | BURGANDY/WHITE", brand: "Vans", price: "29", imageUrl: "https://cdn.shopify.com/s/files/1/0648/0714/1450/files/product_1_image1.jpg?v=1748169351",currencyName: "egp"), path: .constant(NavigationPath()))
}
