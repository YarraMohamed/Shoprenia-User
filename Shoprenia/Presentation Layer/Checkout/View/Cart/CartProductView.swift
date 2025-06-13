//
//  CartProductView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI
import MobileBuySDK

struct CartProductView: View {
    let line: CartLineItem
    var onIncrease: () -> Void
    var onDecrease: () -> Void
    var onDelete: () -> Void
    var onTap: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
                HStack(spacing: 10) {
                    if let imageURL = line.imageURL {
                        AsyncImage(url: imageURL) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .scaledToFit()
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(line.title)
                            .font(.system(size: 16))
                            .minimumScaleFactor(0.5).offset(y:15)
                        
                        Text("Total Price : \(line.price) \(line.currency)")
                            .font(.system(size: 14)).offset(y:15)
                        
                        Text("Size and color : \(line.variantTitle)").font(.system(size: 14)).offset(y:15)
                        
                        HStack {
                            Text("Quantity")
                            Spacer()
                            
                            Button(action: onDecrease) {
                                Image(systemName: "minus.circle.fill")
                            }
                            .buttonStyle(.borderless)
                            
                            Text("\(line.quantity)")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Button(action: onIncrease) {
                                Image(systemName: "plus.circle.fill")
                            }
                            .buttonStyle(.borderless)
                        }.offset(y:15)
                    }
                }
                .padding()
                .frame(width: 350, height: 200)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue.opacity(0.5), lineWidth: 0.5)
                }
                .contentShape(Rectangle())
                            .onTapGesture {
                                onTap()
                            }
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(6)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                }
                .padding(10)
            }
            .buttonStyle(.plain)
        }
    }



//
//#Preview {
//    CartProductView(quantity: .constant(1) ,showAlert: .constant(false))
//}
