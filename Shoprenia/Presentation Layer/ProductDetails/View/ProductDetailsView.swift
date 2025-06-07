import SwiftUI
import MobileBuySDK
import Kingfisher

struct ProductDetailsView: View {
    @State var productId : String
    @State var selectedSize = "Select size"
    @State var selectedColor = "Select color"
    @ObservedObject var viewModel : ProductDetailsViewModel
    
    @Binding var path : NavigationPath
    
    private let reviews = ["1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"]
    private let numberOfReviews = ["5", "10", "15", "20", "25", "30", "35", "40", "45", "50"]
    
    var body: some View {
        
        ScrollView{
            VStack{
                Divider()
                ZStack{
                    KFImage(viewModel.productDetails?.featuredImage?.url)
                        .resizable()
                        .placeholder{
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 310)
                }
                 
                    HStack{
                        Text(viewModel.productDetails?.title ?? "No Name")
                            .font(.system(size: 20,weight: .semibold))
                            .padding(.leading,16)
                        
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        
                        Text("Price : \(viewModel.productDetails?.variants.nodes[0].price.amount ?? 100) \(viewModel.productDetails?.variants.nodes[0].price.currencyCode ?? Storefront.CurrencyCode.egp)")
                                .foregroundStyle(.blue)
                                .font(.system(size: 16,weight: .semibold))
                                .padding(.trailing,16)
                                
                    }
                
                
                HStack{
                    Image("star")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                    
                        Text("\(reviews.randomElement() ?? "1")")
                            .font(.system(size: 12,weight: .semibold))
                    
                        Text("(\(numberOfReviews.randomElement() ?? "1") Reviews)")
                        .foregroundStyle(.gray)
                            .font(.system(size: 12,weight: .semibold))
                        
                    
                    Spacer()
                }
                .padding(.horizontal)
                    
                HStack{
                    Text("Description")
                        .font(.system(size: 16,weight: .semibold))
                        .padding(16)
                    Spacer()
                }
                
                HStack{
                    ScrollView {
                        Text(viewModel.productDetails?.description ?? "No Description")
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
                        ForEach(viewModel.productDetails?.options.first?.optionValues ?? [], id: \.id) { sizeObj in
                            
                            Button(sizeObj.name) {
                                self.selectedSize = sizeObj.name
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
                        ForEach(viewModel.productDetails?.options[1].optionValues ?? [],id:\.id){ colorObj in
                            
                            Button(colorObj.name){
                                self.selectedColor = colorObj.name
                            }
                        }
                    } label: {
                        HStack{
                            Text(self.selectedColor)
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
                    Button("Add to cart"){
                        //Logic hna w bta3
                        print("Added to cart")
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 245, height: 48)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.blue)
                    }
                    
                }
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", image: .heartUnfilled) {
                        print("ok")
                    }
                }
            }
            
        }
        
        
        
        .onAppear{
            viewModel.getProductDetails(id: GraphQL.ID(rawValue: productId))
        }
    }
}

#Preview {

    ProductDetailsView(productId: "gid://shopify/Product/7936016351306",
                       viewModel:ProductDetailsViewModel(productDetailsCase: GetProductDetailsUseCase(repo: ProductDetailsRepository(service: ProductDetailsService()))),
                       path: .constant(NavigationPath()))

}
