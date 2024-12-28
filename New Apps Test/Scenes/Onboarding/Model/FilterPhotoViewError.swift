import DesignSystem

enum FilterPhotoViewError: AppErrorDisplayable, Identifiable {
    case simulator
    case noFaces
    
    public var id: Int { code }
    
    public var title: String {
        switch self {
        case .simulator:
            return String(localized: "Oops")
        case .noFaces:
            return String(localized: "No face")
        }
    }
    
    public var message: String? {
        switch self {
        case .simulator:
            return String(localized: "You have to use real device")
        case .noFaces:
            return String(localized: "you are trying to cheat the system.")
        }
    }
    
    public var code: Int {
        switch self {
        case .simulator:
            return 1
        case .noFaces:
            return 2
        }
    }
    
    public var image: AppContainerImage? {
        switch self {
        case .simulator, .noFaces:
            return AppContainerImage(name: "exclamationmark.triangle.fill")
        }
    }
}
