//
//  AddFromMap.swift
//  Shoprenia
//
//  Created by MAC on 29/05/2025.
//

import SwiftUI

struct AddFromMap: View {
//    @State private var selectedCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            MyMap()
                .padding(.top, 10)
                .cornerRadius(25)
                .frame(height: 570)
            
        
                        NavigationLink(destination: SelectedAddDetails()) {
                            BigButton(buttonText: "Confirm Address").offset(y:20)
                        }
            
            Spacer()
        }
        .navigationTitle("Step 1/2")
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    AddFromMap()
}
