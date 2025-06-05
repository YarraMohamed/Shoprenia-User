//
//  BigButton.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI
struct BigButton: View {
    var buttonText: String
    var body: some View {
        Text(buttonText)
            .frame(width: 300, height: 48)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)
    }
}


#Preview {
    BigButton(buttonText: "button")
}
