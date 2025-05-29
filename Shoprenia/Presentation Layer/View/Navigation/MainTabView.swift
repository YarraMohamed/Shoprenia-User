//
//  MainTabView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct MainTabView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        TabView{
            HomeView(path: $path)
                .tabItem { Image(.home) }

            CategoriesView()
                .tabItem { Image(.category) }

            ProfileTest()
                .tabItem { Image(.user) }
        }
    }
}

#Preview {
    MainTabView(path:.constant(NavigationPath()))
}
