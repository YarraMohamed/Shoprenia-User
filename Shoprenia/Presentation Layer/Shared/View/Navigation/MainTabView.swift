//
//  MainTabView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI
import Swinject

struct MainTabView: View {
    @Binding var path: NavigationPath
    let homeVM : HomeViewModel
    let categoriesVM : CategoriesViewModel
    var body: some View {
        TabView{
            HomeView(viewModel: homeVM, path: $path)
                .tabItem { Image(.home) }

            CategoriesView(viewModel: categoriesVM, path: $path)
                .tabItem { Image(.category) }

           ProfileView(path: $path)
                .tabItem { Image(.user) }
        }
    }
}

#Preview {
   // MainTabView(path:.constant(NavigationPath()))
}
