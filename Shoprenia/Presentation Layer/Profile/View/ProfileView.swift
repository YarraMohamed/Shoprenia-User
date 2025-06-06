//
//  ProfileView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 05/06/2025.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path : NavigationPath
    @EnvironmentObject var vm : AuthenticationViewModel
    var body: some View {
        VStack{
            CustomNavigationBar(path: $path)
            Spacer()
            if vm.isAuthenticated(){
                AuthProfile()
                    .padding(.bottom,100)
            }else{
                GuestProfile(path: $path)
                    .padding(.bottom,100)
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    ProfileView(path: .constant(NavigationPath()))
}
