//
//  OrderHistory.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct OrderHistory: View {
    var body: some View {
        List {
            ForEach(0..<3){_ in
                OrderItem()
            }
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Order History")
    }
}

#Preview {
    OrderHistory()
}
