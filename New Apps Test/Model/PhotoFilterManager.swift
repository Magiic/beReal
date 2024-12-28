import PhotoFilterService

/// Implements decision to which filters will be used depending user purchases
protocol PhotoFilterManager: Sendable {
    func filters(currentUser: CurrentUser) -> PhotoFilterEffectOption
}

/// Implements decision to which filters will be used depending user purchases
struct AppPhotoFilterManager: PhotoFilterManager {
    
    /// Returns filters to apply to the photo
    /// - Parameter currentUser: Current user information. It contains purchases made.
    /// - Returns: Returns filters to apply to the photo
    func filters(currentUser: CurrentUser) -> PhotoFilterEffectOption {
        let purchasedItems = currentUser.purchasedItems
        var filters: PhotoFilterEffectOption = .noiseBigger
        
        if purchasedItems.contains(.disease1) {
            filters.insert(.skinBlackDots)
        }
        
        if purchasedItems.contains(.disease2) || purchasedItems.contains(.disease3) {
            filters.insert(.skinColor)
        }
        
        return filters
    }
}
