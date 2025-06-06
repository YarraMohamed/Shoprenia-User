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
    var body: some View {
        VStack(alignment: .leading){
            UserProfile(userName: title)
                .padding(.bottom,20)
            LazyVGrid(columns: columns,alignment: .leading) {
                ForEach(arr ,id:\.self) { item in
                    HStack{
                        Button(item){
                            print(item)
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
    AuthProfile()
}
