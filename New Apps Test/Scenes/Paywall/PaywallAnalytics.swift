import Foundation

protocol PaywallAnalytics {
    
    func purchase(id: PurchaseItem)
    
    func error(id: PurchaseItem, error: Error)
}

struct AppPaywallAnalytics: PaywallAnalytics {
    
    func purchase(id: PurchaseItem) {}
    
    func error(id: PurchaseItem, error: any Error) {}
}
