import SwiftUI

extension EnvironmentValues {
    /**
        This is an example of different way we can inject dependencies. Via initializer or @Environment swiftUI
        For this purchase I use @Environment.
     */
    @Entry var purchaseManager: PurchaseManageable = PurchaseManager(userStorage: AppCurrentUserStorage())
    @Entry var paywallAnalytics: PaywallAnalytics = AppPaywallAnalytics()
}
