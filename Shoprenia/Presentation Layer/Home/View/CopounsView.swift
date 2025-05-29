//
//  CopounsView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//


import SwiftUI

struct CouponsView: View {
    let items = ["Coupon1", "Coupon2", "Coupon3"]
    @State private var selectedIndex = 0
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<items.count, id: \.self) { index in
                Image(items[index])
                    .resizable()
                    .padding()
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 250)
    }
    
    init(){
        UIPageControl.appearance().currentPageIndicatorTintColor = .app
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
        
    }
}


#Preview {
    CouponsView()
}
