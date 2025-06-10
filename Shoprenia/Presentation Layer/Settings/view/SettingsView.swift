//  SettingsView.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI
import MobileBuySDK
import Foundation

struct SettingsView: View {
    @ObservedObject var viewModel : AddressViewModel
    @EnvironmentObject var vm : AuthenticationViewModel
    var body: some View {
        VStack{
            SectionText(Stext: "Account")
                .padding(.leading)
                .offset(x : -130  )
            
                .onAppear{
                    let accessToken = getCustomerAccessToken()
                    print ("access token : ")
                    print (accessToken)
                }
            
            
            UserProfile(userName: vm.getUserName() ?? "")
                .offset(x : -70 , y : 20)
                .padding(.leading , 150)
            
            SettingList(viewModel :viewModel )
                .offset(y : 40)
                .padding(.bottom)
                
            BigButton(buttonText: "Logout")
                .offset(y: -70)
            
            Spacer()
            
        }
        .padding(.top)
    }
    
    
    private func getCustomerAccessToken() -> String {
        return UserDefaultsManager.shared.retrieveShopifyCustomerAccessToken() ?? ""
    }
        
}
