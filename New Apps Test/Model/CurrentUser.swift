import Foundation

/// Contains user information
struct CurrentUser: Codable, Sendable {
    
    /// Specifies if the user has seen onboarding
    var hasSeenOnboarding = false
    
    /// Purchased items by the user.
    var purchasedItems: Set<PurchaseItem> = []
}
