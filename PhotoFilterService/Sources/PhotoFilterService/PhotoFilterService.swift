import Foundation
import UIKit

/// Filter service to apply effects on images
public protocol PhotoFilterService: Sendable {
    
    /// Apply distortion effect to increase the size of noise
    /// - Parameter data: Image to apply effect
    /// - Parameter effects: Effects to apply
    /// - Returns: Image with new created distortion applied
    func applyDistortion(toImageData data: Data, effects: PhotoFilterEffectOption) async throws -> UIImage?
    
    /// Apply distortion effect to increase the size of noise
    /// - Parameter image: Image to apply effect
    /// - Parameter effects: Effects to apply
    /// - Returns: Image with new created distortion applied
    func applyDistortion(to image: UIImage, effects: PhotoFilterEffectOption) async throws -> UIImage
}
