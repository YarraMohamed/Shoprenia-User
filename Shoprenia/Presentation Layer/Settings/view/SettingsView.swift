//  SettingsView.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel : AddressViewModel
    @EnvironmentObject var vm : AuthenticationViewModel
    @Binding var path: NavigationPath
    var body: some View {
        VStack{
            SectionText(Stext: "Account")
                .padding(.leading)
                .offset(x : -130  )
            
            UserProfile(userName: vm.getUserName() ?? "")
                .offset(x : -70 , y : 20)
                .padding(.leading , 150)
            
            SettingList(viewModel :viewModel, path: $path )
                .offset(y : 40)
                .padding(.bottom)
                
            BigButton(buttonText: "Logout")
                .offset(y: -70)
                .onTapGesture {
                    viewModel.firebaseSignOut()
                    viewModel.googleSignOut()
                    viewModel.removeAllUserDataFromDefaults()
                    vm.isAuth = false
                    path.removeLast(1)
                   // path.append(AppRouter.register)
                }
            
            Spacer()
        }
        .padding(.top)
    }
}
