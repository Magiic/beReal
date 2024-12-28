import SwiftUI

public struct AppPlatformShapeStyle<S: ShapeStyle> {
    public let `iOS`: S
    public let `visionOS`: S
    public let `macOS`: S
    public let `watchOS`: S
    public let `tvOS`: S
    
    public init(all color: S) {
        self.iOS = color
        self.visionOS = color
        self.macOS = color
        self.watchOS = color
        self.tvOS = color
    }
    
    public init(iOS: S, visionOS: S, macOS: S, watchOS: S, tvOS: S) {
        self.iOS = iOS
        self.visionOS = visionOS
        self.macOS = macOS
        self.watchOS = watchOS
        self.tvOS = tvOS
    }
}

public extension AppPlatformShapeStyle {
    
    static var `default`: AppPlatformShapeStyle<Color> {
        AppPlatformShapeStyle<Color>(
            iOS: .primary,
            visionOS: .primary,
            macOS: .primary,
            watchOS: .primary,
            tvOS: .primary
        )
    }
}
