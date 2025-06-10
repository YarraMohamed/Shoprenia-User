//
//  AboutUs.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        ScrollView {
            
            
            Text("About Shoprenia").font(.title).foregroundStyle(Color.blue)
            Text("""
                Welcome to Shoprenia, your ultimate multi-vendor shopping destination!
                
                We created Shoprenia to make your shopping experience simple, smart, and secure. Whether you're browsing the latest trends, discovering new brands, or finding your daily essentials — we've got it all in one place.
                """)
                    .multilineTextAlignment(.leading)
            
            Text(" Shoprenia offers").font(.title).foregroundStyle(Color.blue)
                .offset(y : 20)
            Text("""
        • A wide range of products from trusted vendors.
        • Smart search and advanced filtering.
        • Easy cart and favorites management.
        • Exclusive discounts and Apple Pay integration.
        • A complete history of your orders, always accessible.
        
        Our mission is to bring convenience and joy to your shopping journey.
        We’re constantly improving and adding new features to serve you better. Thank you for being a part of the Shoprenia family!
        """)
            
//            .offset(x : -20,y: -10)
            .padding(.top,10)
        }
        .navigationTitle("About Us")
        .padding(20)
    }
}

#Preview {
    AboutUs()
}
