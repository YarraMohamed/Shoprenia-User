//
//  HelpCenter.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct HelpCenter: View {
    var body: some View {
        
        VStack{
            
            
            Image( "helpCenter")
                .resizable()
                .frame(width: 250 , height: 250 )
                .clipShape(Circle())
                .offset(y : -150 )
            
            Text("How can we help you?")
                .offset(y: -100)
                .foregroundStyle(Color.blue)
                .fontWeight(.bold)
                .font(.title)
            Text("It looks like you're having a problem. We're here to help you so please get in touch with us!")
                .foregroundStyle(Color.blue.opacity(0.8))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
                .offset(y : -80)
            
            
            
            HStack {
                ZStack{
                  Image(systemName: "phone")
                        .scaledToFit()
                        .frame(width: 80 , height:  80 )
                        .background(Color.blue.opacity(0.5))
                        .clipShape(Circle())
                    
                    Link("   ", destination: URL(string: "tel:01023199644")!)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    
                }
                Spacer()
                
                ZStack{
                  Image(systemName: "tray")
                        .scaledToFit()
                        .frame(width: 80 , height:  80 )
                        .background(Color.blue.opacity(0.5))
                        .clipShape(Circle())
                    
                    
                    Link("   ", destination: URL(string: "mailto:reham2002ibrahim@gmail.com")!)
                        .font(.title2)
                        .fontWeight(.semibold)
                }

            }
            .padding(.horizontal, 50)
            
        }
        .navigationTitle("Help Center")
        
    }
}

#Preview {
    HelpCenter()
}


