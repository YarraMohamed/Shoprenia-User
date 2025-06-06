//
//  HomeView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var path : NavigationPath
    var body: some View {
        VStack(alignment: .leading){
            CustomNavigationBar(path: $path)
            CouponsView()
            Text("Brands")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.app)
            
            if viewModel.brands.isEmpty{
                ProgressView("Loading...")
                   .frame(height: 350)
            }else{
                BrandsGridView(path: $path, brands: viewModel.brands)
                    .frame(height: 350)
            }
            
        }
        .onAppear{
            viewModel.loadBrands()
        }
        .padding(.leading,15)
        .padding(.trailing,15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(fetchBrandsUseCase: GetVendors(repository: VendorsRepository(vendorService: VendorService()))), path: .constant(NavigationPath()))
}
