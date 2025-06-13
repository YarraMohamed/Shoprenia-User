import SwiftUI

struct CouponsView: View {
    

    @State private var selectedIndex = 0
    @State private var copiedMessage = ""

    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $selectedIndex) {
                ForEach(0..<items.count, id: \.self) { index in
                    ZStack(alignment: .bottomTrailing) {
                        Image(items[index])
                            .resizable()
                            .scaledToFill()
                            .frame(height: 230)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .padding(.horizontal, 16)
                            .shadow(radius: 4)

                        Button(action: {
                            let codeToCopy = codes[index]
                            UIPasteboard.general.string = codeToCopy
                            copiedMessage = "Code copied!"

                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                copiedMessage = ""
                            }
                        }) {
                            Text("Copy Code")
                                .font(.system(size: 14, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.black.opacity(0.5))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(12)
                        .contentShape(Rectangle())
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 250)

            if !copiedMessage.isEmpty {
                Text(copiedMessage)
                    .foregroundColor(.blue.opacity(0.5))
                    .font(.system(size: 14))
                    .padding(.top, 4)
                    .transition(.opacity)
            }
        }
    }

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .app
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
    }
    let items = ["Coupon1", "Coupon2", "Coupon3"]
    let codes = ["SUMMER15", "SUMMER10", "WELCOME50"]
}

