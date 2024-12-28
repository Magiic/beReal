import Foundation

/// Represents the photo filtered
struct UserPhoto: Codable, Identifiable, Hashable {
    
    /// Identifier
    let id: UUID
    
    /// Photo where filters was applied
    let photo: Data
    
    /// Specifies the date creation
    let date: Date
}
