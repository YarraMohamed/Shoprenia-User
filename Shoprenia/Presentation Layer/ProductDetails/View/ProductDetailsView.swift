import SwiftUI
import MobileBuySDK
import Kingfisher

struct ProductDetailsView: View {
    @State var productId : String
    @State var selectedSize = "Select size"
    @State var selectedColor = "Select color"
    @State private var isInCart = false
    @State private var showToast = false
    @State var showAlert = false
    @State private var toastMessage = ""
    @Binding var path : NavigationPath
    @State private var convertedPrice: Double? = nil
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"

    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var viewModel : ProductDetailsViewModel
    
    
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
                        
                        Text(
                            selectedCurrency == "USD"
                             ? "\(String(format: "%.2f", convertedPrice ?? 0)) USD"
                             : "\(String(describing: viewModel.productDetails?.variants.nodes[0].price.amount ?? 0)) EGP"
                         )
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
                    Button("Add to cart") {
                        if let matchedVariant = viewModel.getMatchingVariant(selectedSize: selectedSize, selectedColor: selectedColor) {
                            viewModel.addToCart(variantId: matchedVariant.id.rawValue, quantity: 1)
                            toastMessage = "Added successfully.\nYou can select the quantity in the shopping cart."

                            showToast = true
                        }
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
                                    if authViewModel.isAuthenticated(){
                                        guard let product = viewModel.productDetails else{
                                            return
                                        }
                                        viewModel.saveShopifyProduct(product)
                                    }else{
                                        self.showAlert = true
                                    }
                                }
                            }
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("You need to login"),
                                message: Text("Please login to continue."),
                                primaryButton: .default(Text("Ok"), action: {
                                    path.append(AppRouter.register)
                                }),
                                secondaryButton: .cancel()
                            )
                        }
                    }
        
        
        .onAppear{
            viewModel.getProductDetails(id: GraphQL.ID(rawValue: productId))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    if selectedCurrency == "USD",
                       let priceDecimal = viewModel.productDetails?.variants.nodes[0].price.amount {
                        let priceDouble = NSDecimalNumber(decimal: priceDecimal).doubleValue
                        convertedPrice = convertEGPToUSD(priceDouble)
                    }
                }
        }
        .overlay(
            VStack {
                if showToast {
                    Text(toastMessage)
                        .font(.subheadline)
                        .padding()
                        .background(Color.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .transition(.opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showToast = false
                                }
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(.easeInOut, value: showToast)
        )


    }
    
    private func convertEGPToUSD(_ amount: Double) -> Double {
        let exchangeRate: Double = 1.0 / 49.71
        return amount * exchangeRate
    }

}


