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
            if vm.isAuth{
                AuthProfile(title: vm.getUserName() ?? "" )
                    .padding(.bottom,100)
            }else{
                GuestProfile(path: $path)
                    .padding(.bottom,100)
            }
            Spacer()
        }
        .onAppear{
            vm.isAuthenticated()
        }
        .padding()
    }
}


