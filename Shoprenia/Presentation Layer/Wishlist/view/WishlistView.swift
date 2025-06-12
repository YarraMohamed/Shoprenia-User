import SwiftUI
import MobileBuySDK
import SwiftData

struct WishlistView: View {
    
    @ObservedObject var viewModel : WishlistViewModel
    @State var showAlert = false
    @State private var index : IndexSet.Element?
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        List{
            ForEach(viewModel.wishlist) { item in
    
                    WishlistRow(product: item, path:$path)
                    .onTapGesture {
                        path.append(AppRouter.productDetails(productId: item.id))
                    }
                    .padding(.bottom,2)
                    
            }
            .onDelete { indexSet in
                if let index = indexSet.first{
                    self.showAlert = true
                    self.index = index
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .navigationTitle("Wishlist")
        .toolbar{
            EditButton()
        }
        .onAppear{
            viewModel.fetchWishlistFromFireStore()
        }
        .alert("Delete item?", isPresented: $showAlert) {
            Button("Cancel",role: .cancel){}
            Button ("Delete", role: .destructive){
                if let index = self.index {
                    let product = viewModel.wishlist[index]
                    viewModel.deleteProductFromFirestore(productId: product.id)
                    viewModel.wishlist.remove(at: index)
                }
            }
        }
    }
}

#Preview {
    WishlistView(viewModel: WishlistViewModel(deleteFromWishlistCase: DeleteFromWishlist(repo: WishlistRepository(firestore: FireStoreServices())), fetchwishlistCase: FetchWishlistFromFirestore(repo: WishlistRepository(firestore: FireStoreServices()))), path: .constant(NavigationPath()))
}
