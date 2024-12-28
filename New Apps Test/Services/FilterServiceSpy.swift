import PhotoFilterService
import UIKit

struct FilterServiceSpy: PhotoFilterService {
    func applyDistortion(toImageData data: Data, effects: PhotoFilterEffectOption) async throws -> UIImage? {
        UIImage(resource: .onboardingIllustration)
    }
    
    func applyDistortion(to image: UIImage, effects: PhotoFilterEffectOption) async throws -> UIImage {
        UIImage(resource: .onboardingIllustration)
    }
}
