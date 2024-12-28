import DesignSystem
import SwiftUI

struct PaywallView: View {
    
    @Environment(\.purchaseManager) private var purchase
    @Environment(\.paywallAnalytics) private var analytics
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingAlert = false
    @State private var error: ErrorData?
    
    var body: some View {
        GridSelectionView(
            items: PaywallViewItem.items,
            columns: [
                GridItem(.adaptive(minimum: 150, maximum: .infinity), spacing: 3)
            ],
            spacing: 8
        ) {
            EmptyContentView(
                content: EmptyContentViewData(
                    text: "No content",
                    description: "No content",
                    iconName: "purchased.circle.fill",
                    action: EmptyContentViewData.Action(
                        title: "Do nothing",
                        iconName: nil,
                        tap: {
                        })
                )
            )
        } content: { item in
            PaywallItemView(item: item) {
                Task {
                    do {
                        try await purchase.purchase(id: item.id)
                        analytics.purchase(id: item.id)
                        isShowingAlert.toggle()
                    } catch {
                        analytics.error(id: item.id, error: error)
                        self.error = ErrorData(error: AppViewGenericError.generic)
                    }
                }
            }
        }
        .padding(.top, 60)
        .padding(.horizontal)
        .ignoresSafeArea()
        .alert("Congratulations!", isPresented: $isShowingAlert) {
            Button("Ok", role: .cancel) {
                dismiss()
            }
        }
        .overlay {
            if let error {
                PageErrorButtonsView(
                    error: error,
                    buttons: [
                        ButtonPageErrorAction(
                            id: 1,
                            titleButton: String(localized: "Retry"),
                            action: {
                                self.error = nil
                            }
                        )
                    ],
                    foregroundStyle: .init(all: Color.primaryInvert),
                    backgroundColor: Color.primaryApp
                )
                PageErrorView(error: error)
            }
        }
    }
}

#Preview {
    PaywallView()
        .environment(\.purchaseManager, PurchaseManager(userStorage: AppCurrentUserStorage()))
}
