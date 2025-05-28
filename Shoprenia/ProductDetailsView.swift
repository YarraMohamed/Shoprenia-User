import SwiftUI
import MobileBuySDK
import Kingfisher
struct ProductDetailsView: View {
    @State var productId : String
    @State var productDetails : Storefront.Product? = nil
    @State var selectedSize = "Select size"
    @State var selectedColor = "Select color"
    var body: some View {
        VStack{
            
            ZStack{
                KFImage(productDetails?.featuredImage?.url)
                    .resizable()
                    .placeholder{
                        ProgressView()
                    }
                    .onFailure{ error in
                        print("Failed to get product image in details \(error.localizedDescription)")
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 310)
            }
            
            
                
                HStack{
                    Text(productDetails?.title ?? "No Name")
                        .font(.system(size: 20,weight: .semibold))
                        .padding(.leading,16)
                    
                    Spacer()
                }
                
                HStack{
                    Spacer()
                    
                    Text("\(productDetails?.variants.nodes[0].price.amount ?? 100) \(productDetails?.variants.nodes[0].price.currencyCode ?? Storefront.CurrencyCode.egp)")
                            .foregroundStyle(.blue)
                            .font(.system(size: 16,weight: .semibold))
                            .padding(.trailing,16)
                            
                }
                
            HStack{
                Text("Description")
                    .font(.system(size: 16,weight: .semibold))
                    .padding(16)
                Spacer()
            }
            
            HStack{
                ScrollView {
                    Text(productDetails?.description ?? "No Description")
                        .foregroundColor(Color(hex: "4C4B4B"))
                        .padding(.horizontal,16)
                        
                }
                Spacer()
            }.frame(height: 100)
            
            
            HStack{
                Text("Size")
                    .font(.system(size: 16,weight: .semibold))
                    .padding(16)
                Spacer()
            }
            
            HStack {
                Menu {
                    ForEach(productDetails?.options[0].values ?? [], id: \.self) { size in
                        
                        Button(size) {
                            self.selectedSize = size
                        }
                    }
                } label: {
                    HStack {
                        Text(selectedSize)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.blue)
                    }
                    .padding(15)
                    .background(Color(hex: "D3D3D3"))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal,16)
            .frame(maxWidth: .infinity)
                
            
            HStack{
                Text("Color")
                    .font(.system(size: 16,weight: .semibold))
                    .padding(16)
                Spacer()
            }
            
            HStack{
                Menu{
                    ForEach(productDetails?.options[1].values ?? [],id:\.self){ color in
                        
                        Button(color){
                            selectedColor = color
                        }
                    }
                } label: {
                    HStack{
                        Text(selectedColor)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.blue)
                    }
                    .padding(15)
                    .background(Color(hex: "D3D3D3"))
                    .cornerRadius(8)
                    
                }
            }
            .padding(.horizontal,16)
            .frame(maxWidth: .infinity)
            
            HStack{
                Button("Buy Now"){
                    //Logic hna w bta3
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 245, height: 48) // Fixed width & height
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.blue)
                }
                
            }
            Spacer()
        }
        .navigationTitle("HJe")
        .onAppear{
            GraphQLServices.shared.fetchProductDetails(id: GraphQL.ID(rawValue: productId)) { result in
                switch result {
                case .success(let productDetails):
                    self.productDetails = productDetails
                    
                case .failure(let error):
                    print("Error in fetching product details : \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    ProductDetailsView(productId: "gid://shopify/Product/7936016351306")
}
