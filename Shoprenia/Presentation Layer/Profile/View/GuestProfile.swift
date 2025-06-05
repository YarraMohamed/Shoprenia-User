//
//  GuestProfile.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 05/06/2025.
//

import SwiftUI

struct GuestProfile: View {
    @Binding var path : NavigationPath
    var body: some View {
        VStack{
            
            Text("Welcome!")
                .foregroundColor(.app)
                .fontWeight(.medium)
                .font(.largeTitle)
           Text("You need to login")
                .foregroundColor(.app)
                .fontWeight(.medium)
                .font(.largeTitle)
            
            Button("Login"){
                path.append(AppRouter.login)
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 345, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
            .padding(.top,50)
            .padding(.bottom,20)
            
            Button("Signup"){
        
            }
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 345, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
                
        }.padding()
    }
}

#Preview {
    GuestProfile(path: .constant(NavigationPath()))
}
