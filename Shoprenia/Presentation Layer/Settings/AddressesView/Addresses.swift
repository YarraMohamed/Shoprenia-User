//
//  Addresses.swift
//  Demo SWPro
//
//  Created by Reham on 29/05/2025.
//

import SwiftUI

struct Addresses: View {
    var body: some View {
            VStack{
                SectionText(Stext: "Account")
                    .padding(.leading)
                    .offset(x : -130  )

                UserProfile()
                    .offset(x : -70 )
                    .padding(.leading , 150)

                NavigationLink(destination: AddFromMap()) {
                    BigButton(buttonText: "Add New Address")
                }                    
                    .offset(y: 420)
                
                
                
                Spacer()
            }
            
        
  
    }
}




#Preview {
    Addresses()
}
