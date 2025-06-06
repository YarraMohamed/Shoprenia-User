//
//  UserProfile.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct UserProfile: View {
    var userName : String = "Account"
    var body: some View {
        
        HStack{

            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 50 , height: 50 )
                .clipShape(Circle())
                .padding(.leading,20)
                .padding(.trailing,20)
//                .offset(x : -80 )

            
            Text(userName)
                .fontWeight(.semibold)
                .foregroundStyle(.app)
            
            Spacer()
          
            
        }.frame(width: 350 , height: 100)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(25)
            .padding(.horizontal)
    }
}

#Preview {
    UserProfile()
}
