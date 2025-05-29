//
//  BrandView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI

struct BrandView: View {
    var body: some View {
        VStack{
            Image(.brandImg)
                .resizable()
                .frame(width: 150, height: 150)
            Spacer()
            Text("Addidas")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .fontDesign(.rounded)
            
        }.frame(width: 170,height: 200)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 3)
    }
}

#Preview {
    BrandView()
}
