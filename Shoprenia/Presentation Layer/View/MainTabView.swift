//
//  MainTabView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView{
            NavigationStack{
                HomeView()
            }.tabItem {
                Image(.home)
            }
            
            NavigationStack{
                CategoriesView()
            }.tabItem {
                Image(.category)
            }
            
            NavigationStack{
                
            }.tabItem {
                Image(.user)
            }
        }
        
    }
}

#Preview {
    MainTabView()
}
