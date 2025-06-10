import SwiftUI

struct SliderView: View {
    @Binding var sliderValue: Double
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Filter")
                .font(.system(size: 16, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top)
            
           
            VStack(spacing: 16) {
                Text("Price Range")
                    .font(.system(size: 16, weight: .semibold))
                
                Text("EGP \(sliderValue, specifier: "%.0f")")
                    .font(.system(size: 14, weight: .semibold))
                
                Slider(
                    value: $sliderValue,
                    in: 19...400,
                    step: 1,
                    onEditingChanged: { _ in
                        print("Slider value is now: \(sliderValue)")
                    },
                    minimumValueLabel: Text("EGP 19")
                        .font(.system(size: 14, weight: .semibold)),
                    maximumValueLabel: Text("EGP 400")
                        .font(.system(size: 14, weight: .semibold)),
                    label: { Text("Price Range Slider") }
                )
                
                Button("Apply Filter") {
                    isPresented = false
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 343, height: 48)
                .background {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.blue)
                }
            }
            .frame(maxHeight: .infinity)
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var previewValue: Double = 19
    @Previewable @State var previewPres: Bool = true
    SliderView(sliderValue: $previewValue,isPresented: $previewPres)
}
