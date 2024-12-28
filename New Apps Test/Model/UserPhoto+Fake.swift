import UIKit

/**
 Use this for preview
 */
extension UserPhoto {
    
    static let photoData = UIImage(resource: .onboardingIllustration).pngData()!
    
    static let fake = UserPhoto(
        id: UUID(),
        photo: photoData,
        date: Date()
    )
    
    static let fake2 = UserPhoto(
        id: UUID(),
        photo: photoData,
        date: Date()
    )
    
    static let fake3 = UserPhoto(
        id: UUID(),
        photo: photoData,
        date: Date()
    )
    
    static let fake4 = UserPhoto(
        id: UUID(),
        photo: photoData,
        date: Date()
    )
}

/**
 Use this for preview
 */
extension UserPhotoCollection {
    
    static let fake = UserPhotoCollection(photos: [
        UserPhoto.fake,
        UserPhoto.fake2,
        UserPhoto.fake3,
        UserPhoto.fake4
    ])
}
