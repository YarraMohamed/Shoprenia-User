//
//  UserProfile.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct UserProfile: View {
    var body: some View {
        
        HStack{

            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 50 , height: 50 )
                .clipShape(Circle())
                .offset(x : -80 )

            
            Text("user name ")
                .foregroundStyle(.blue)
          
            
        }.frame(width: 350 , height: 100)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(25)
            .padding(.horizontal)
    }
}

#Preview {
    UserProfile()
}
