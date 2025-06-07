//
//  HeaderLabel.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct HeaderText: View {
    var Htext = ""
    var body: some View {
        Text(Htext)
            .font(.system(size: 16 , weight: .bold , design: .serif))
            .foregroundStyle(.blue)
    }
}

#Preview {
    HeaderText(Htext: "Settings")
}
