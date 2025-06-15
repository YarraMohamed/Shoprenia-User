import SwiftUI

struct CurrencyPicker: View {
    var title: String
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "EGP"
    @State private var showingCurrencyPicker = false

    var body: some View {
        Button(action: {
            showingCurrencyPicker = true
        }) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.blue)

                Spacer()

                Text(selectedCurrency)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            .frame(height: 48)
        }
        .actionSheet(isPresented: $showingCurrencyPicker) {
            ActionSheet(
                title: Text("Select Currency"),
                buttons: [
                    .default(Text("EGP")) { selectedCurrency = "EGP" },
                    .default(Text("USD")) { selectedCurrency = "USD" },
                    .cancel()
                ]
            )
        }
    }
}
