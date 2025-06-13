//
//  OrderHistory.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI
import MobileBuySDK

struct OrderHistory: View {
    @ObservedObject var  viewModel : OrderHistoryViewModel
    @EnvironmentObject var vm : AuthenticationViewModel
    var body: some View {
        VStack{
            if viewModel.orders.isEmpty{
                VStack(alignment: .center){
                    Image(.empty)
                        .resizable()
                        .frame(width: 200,height: 200)
                        .padding(.bottom,20)
                    Text("You have no orders, Place your first order now!")
                        .frame(width: 200)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.app)
                }
            }else{
                List {
                    ForEach(viewModel.orders ,id: \.id) { order in
                        OrderItem(order: order)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            
        }.onAppear {
            viewModel.getOrderHistory(accessToken: vm.getAccessToken() ?? "")
        }
        
        .navigationTitle("Orders History")
       
    }
}

#Preview {
    //OrderHistory()
}
