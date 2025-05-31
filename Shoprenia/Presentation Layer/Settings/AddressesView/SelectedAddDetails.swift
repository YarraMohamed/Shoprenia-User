//
//  SelectedAddDetails.swift
//  Shoprenia
//
//  Created by MAC on 29/05/2025.
//

import SwiftUI

struct SelectedAddDetails: View {
    @State private var addName = ""
    @State private var streetName = ""
    @State private var phoneNumber = ""
    @State private var buildingNumber = ""
    @State private var floorNumber = ""
    @State private var apartNumber = ""
    @State private var landmark = ""
    var body: some View {
        
        
        VStack {

            Image(systemName: "shippingbox.fill")
                .resizable()
                
                .frame(width: 150, height: 150)
                .foregroundStyle(Color.blue.opacity(0.4))
                .offset(y:20)


            CustomTextField(
                placeholder: "Address Name ex: Home",
                text: $addName
            )
            .offset(y:50)
            
                    CustomTextField(placeholder: "Street Name", text: $streetName)            .offset(y:60)


            HStack{
                CustomTextField(placeholder: "Phone Number", text: $phoneNumber)
                
                CustomTextField(
                    placeholder: "Building No",
                    text: $buildingNumber
                )
                Spacer()
  
            }
            .offset(y:70)
            HStack{
                CustomTextField(placeholder: "Floor Number", text: $floorNumber)
                
                CustomTextField(
                    placeholder: "Apartment No",
                    text: $apartNumber
                )
                Spacer()
  
            }   .offset(y:80)
            CustomTextField(placeholder: "Land Mark", text: $landmark)   .offset(y:90)

            
            BigButton(buttonText: "Save Changes").offset(y:150)


            

            Spacer()
        }
        .padding()
        .navigationTitle("Step 2/2")
        .navigationBarTitleDisplayMode(.inline)
    
    }
}

#Preview {
    SelectedAddDetails()
}


