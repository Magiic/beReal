import Foundation

/// Contains all photo filtered
struct UserPhotoCollection: Codable {
    
    /// Photos where filters was applied
    var photos: [UserPhoto]
    
    /// Sort photos by date from most recent to older
    var sortedPhotos: [UserPhoto] {
        photos.sorted(using: KeyPathComparator(\.date, order: .reverse))
    }
}
