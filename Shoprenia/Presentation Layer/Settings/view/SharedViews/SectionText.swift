//
//  SectionText.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct SectionText: View {
    var Stext = ""
    var body: some View {
        Text(Stext)
            .font(.system(size: 26 , weight: .bold , design: .serif))
            .foregroundStyle(.blue)
    }
}

#Preview {
    SectionText(Stext: "Account")
}
