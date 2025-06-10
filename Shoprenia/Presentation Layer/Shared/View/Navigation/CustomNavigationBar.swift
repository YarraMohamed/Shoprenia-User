//
//  CustomNavigationBar.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct CustomNavigationBar: View {
    @State var showAlert : Bool = false
    @Binding var path : NavigationPath
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        HStack{
            Text("Shoprenia")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.serif)
                .foregroundColor(.app)
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    path.append(AppRouter.search)
                }) {
                    Image(.search)
                }
                
                Button(action: {
                    if viewModel.isAuthenticated(){
                        path.append(AppRouter.cart)
                    }else{
                        showAlert = true
                    }
                }) {
                    Image(.cart)
                }
                
                Button(action: {
                    if viewModel.isAuthenticated(){
                        path.append(AppRouter.wishlist)
                    }else{
                        showAlert = true
                    }
                }) {
                    Image(.heart)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
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
}



#Preview {
    CustomNavigationBar(path:.constant(NavigationPath()))
}

