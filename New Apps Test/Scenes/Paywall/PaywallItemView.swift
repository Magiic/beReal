import  DesignSystem
import SwiftUI

struct PaywallItemView: View {
    let item: PaywallViewItem
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Text(item.name)
                    .headlineTextStyle()
                
                Text(item.details)
                    .multilineTextAlignment(.leading)
                    .footnoteTextStyle()
                Text(item.price)
                    .headlineTextStyle(color: .init(all: Color.primaryInvert))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 16)
                    .background(Color.primaryApp, in: .rect(cornerRadius: 4))
                    .padding(.top)
            }
            .foregroundStyle(Color.primary)
        }
        .padding()
        .background(Color.systemGray5, in: .rect(cornerRadius: 8))
    }
}

#Preview {
    PaywallItemView(
        item: PaywallViewItem.items[0],
        action: {
        })
}
