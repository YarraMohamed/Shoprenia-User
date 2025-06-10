//
//  AuthProfile.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 05/06/2025.
//

import SwiftUI

struct AuthProfile: View {
    var title : String = "Account"
    var arr : [String] = ["Orders","Wishlist","Settings"]
    let columns : [GridItem] = [GridItem(.flexible())]
    @Binding var path: NavigationPath
    var body: some View {
        VStack(alignment: .leading){
            UserProfile(userName: title)
                .padding(.bottom,20)
            LazyVGrid(columns: columns,alignment: .leading) {
                ForEach(arr ,id:\.self) { item in
                    HStack{
                        Button(item){
                            switch item {
                                case "Settings":
                                path.append(AppRouter.settings)
                                case "Wishlist":
                                path.append(AppRouter.favorites)
                            default:
                                path.append(AppRouter.pastOrders)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Divider()
                    
                }
                .padding(15)
                .foregroundStyle(.app)
                .font(.title2)
                .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    AuthProfile(path: .constant(NavigationPath()))
}
