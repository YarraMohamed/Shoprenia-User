//
//  HomeView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
//    @State private var showSearch = false
    var body: some View {
        VStack(alignment: .leading){
            CustomNavigationBar()
//                .fullScreenCover(isPresented: $showSearch) {
//                            PlaceholderView()
//                        }
            CouponsView()
            Text("Brands")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.app)
            
            if viewModel.brands.isEmpty{
                ProgressView("Loading...")
                   .frame(height: 350)
            }else{
                BrandsGridView(brands: viewModel.brands)
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

    init() {
        let service = VendorService()
        let repo = VendorsRepository(vendorService: service)
        let useCase = GetVendors(repository: repo)
        _viewModel = StateObject(wrappedValue: HomeViewModel(fetchBrandsUseCase: useCase))
    }
}

#Preview {
    HomeView()
}
