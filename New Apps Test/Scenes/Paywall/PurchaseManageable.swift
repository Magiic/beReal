import Foundation

protocol PurchaseManageable {
    
    /// Purchase a disease
    /// - Parameter id: Purchase type id
    func purchase(id: PurchaseItem) async throws
}

actor PurchaseManager: PurchaseManageable {
    
    let userStorage: CurrentUserStorage
    
    init(userStorage: CurrentUserStorage) {
        self.userStorage = userStorage
    }
    
    /// Purchase a disease
    /// - Parameter id: Purchase type id
    func purchase(id: PurchaseItem) async throws {
        var currentUser = try userStorage.get()
        currentUser.purchasedItems.insert(id)
        try userStorage.store(user: currentUser)
    }
}
