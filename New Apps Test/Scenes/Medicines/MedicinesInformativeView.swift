import DesignSystem
import SwiftUI

struct MedicinesInformativeView: View {
    
    let isShowingPaywallButton: Bool
    @State private var isShowingPaywall = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Buy new medicines to improve your health. Don't forget to share your health in social network otherwise we will send army to check.")
                .multilineTextAlignment(.leading)
            
            if isShowingPaywallButton {
                Button("Buy") {
                    isShowingPaywall.toggle()
                }
                .buttonStyle(TertiaryButtonStyle.default)
            }
        }
        .padding()
        .background(Color.systemGray6, in: .rect(cornerRadius: 8))
        .sheet(isPresented: $isShowingPaywall) {
            PaywallView()
        }
    }
}

#Preview("Not Display Button") {
    MedicinesInformativeView(isShowingPaywallButton: false)
}

#Preview("Display Button") {
    MedicinesInformativeView(isShowingPaywallButton: true)
}
