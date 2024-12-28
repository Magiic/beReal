import Foundation

public enum AppViewGenericError: AppErrorDisplayable, Identifiable {
    case generic
    case networkInternet
    
    public var id: Int { code }
    
    public var title: String {
        switch self {
        case .generic:
            return String(localized: LocalizedStringResource("Oops"))
        case .networkInternet:
            return String(localized: LocalizedStringResource("Network connection missing"))
        }
    }
    
    public var message: String? {
        switch self {
        case .generic:
            return String(localized: LocalizedStringResource("An error has occurred. Retry later"))
        case .networkInternet:
            return String(localized: LocalizedStringResource("Check your internet connection"))
        }
    }
    
    public var code: Int {
        switch self {
        case .generic:
            return 1
        case .networkInternet:
            return 2
        }
    }
    
    public var image: AppContainerImage? {
        switch self {
        case .generic:
            return AppContainerImage(name: "exclamationmark.triangle.fill")
        case .networkInternet:
            return AppContainerImage(name: "wifi.exclamationmark")
        }
    }
}
