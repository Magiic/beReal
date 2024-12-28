import os.log

public struct AppLogger: Sendable {
    
    public static let subsystem: String = "com.beill"
    
    public static let onboarding = Logger(subsystem: subsystem, category: "Onboarding")
    public static let illHistory = Logger(subsystem: subsystem, category: "Ill History")
    public static let featuredPhotos = Logger(subsystem: subsystem, category: "Featured Photos")
}
