//
//  FloatingButtonView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 03/06/2025.
//

import SwiftUI

struct FloatingButtonView: View {
    @Binding var isMenuExpanded : Bool
    @ObservedObject var viewModel : CategoriesViewModel
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 16) {
                if isMenuExpanded {
                    Button(action: {
                        viewModel.selectedSubCategory = nil
                        isMenuExpanded = false
                    }) {
                        Image(.allProducts)
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.green)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    
                    Button(action: {
                        viewModel.selectedSubCategory = "T-SHIRTS"
                        isMenuExpanded = false
                    }) {
                        Image(.tShirt)
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    Button(action: {
                        viewModel.selectedSubCategory = "SHOES"
                        isMenuExpanded = false
                    }) {
                        Image(.shoes)
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.green)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    Button(action: {
                        viewModel.selectedSubCategory = "ACCESSORIES"
                        isMenuExpanded = false
                    }) {
                        Image(.accessories)
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.green)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                }
                
                Button(action: {
                    withAnimation(.spring()) {
                        isMenuExpanded.toggle()
                    }
                }) {
                    Image(systemName: isMenuExpanded ? "xmark" : "plus")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
    

    }
}

