import Foundation

struct PaywallViewItem: Identifiable, Hashable {
    /// Purchase identifier
    let id: PurchaseItem
    
    /// Name displayed for the purchase id specified
    let name: String
    
    /// Details displayed for the purchase id specified
    let details: String
    
    /// Price displayed for the purchase id specified
    let price: String
}

extension PaywallViewItem {
    
    /// All purchased items.
    static let items: [PaywallViewItem] = [
        PaywallViewItem(
            id: PurchaseItem.disease1,
            name: "Disease",
            details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
            price: "1$"
        ),
        PaywallViewItem(
            id: PurchaseItem.disease2,
            name: "Disease 2",
            details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
            price: "1$"
        ),
        PaywallViewItem(
            id: PurchaseItem.disease3,
            name: "Disease 3",
            details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt",
            price: "1$"
        )
    ]
}
