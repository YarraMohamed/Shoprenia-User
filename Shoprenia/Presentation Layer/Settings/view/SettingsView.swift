//
//  ContentView.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm : AuthenticationViewModel
    var body: some View {
        VStack{
            SectionText(Stext: "Account")
                .padding(.leading)
                .offset(x : -130 , y : +70 )
            
            UserProfile(userName: vm.getUserName() ?? "")
                .offset(x : -70 , y : 100)
                .padding(.leading , 150)
            
            SettingList()
                .offset(y : 100)
                .padding(.bottom)
                
            BigButton(buttonText: "Logout")
                .offset(y: -70)
            
            Spacer()
            
        }
        .padding(.top)
    }
}

#Preview {
    SettingsView()
}
