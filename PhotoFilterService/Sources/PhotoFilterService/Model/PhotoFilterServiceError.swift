import Foundation

public enum PhotoFilterServiceError: Error, LocalizedError {
    case invalidImage
    case simulator
    case perform(Error)
    case filter
    case noFaces
    
    public var errorDescription: String? {
        switch self {
        case .invalidImage:
            "Invalid image"
        case .simulator:
            "You have to use real device"
        case .perform(let error):
            "Detection face failed \(error.localizedDescription)"
        case .filter:
            "Filter image failed"
        case .noFaces:
            "No faces"
        }
    }
}
