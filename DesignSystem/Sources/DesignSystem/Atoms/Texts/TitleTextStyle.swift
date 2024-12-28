import SwiftUI

public struct TitleTextStyle<S: ShapeStyle>: TextStyleModifier {
    public let foregroundStyle: AppPlatformShapeStyle<S>
    
    public init(foregroundStyle: AppPlatformShapeStyle<S>) {
        self.foregroundStyle = foregroundStyle
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.title)
            #if os(visionOS)
            .foregroundStyle(foregroundStyle.visionOS)
            #elseif os(iOS)
            .foregroundStyle(foregroundStyle.iOS)
            #elseif os(macOS)
            .foregroundStyle(foregroundStyle.macOS)
            #elseif os(tvOS)
            .foregroundStyle(foregroundStyle.tvOS)
            #elseif os(watchOS)
            .foregroundStyle(foregroundStyle.watchOS)
            #else
            .foregroundStyle(foregroundStyle.iOS)
            #endif
    }
}

public extension View {
    func titleTextStyle(color: AppPlatformShapeStyle<Color> = .default) -> some View {
        modifier(TitleTextStyle(foregroundStyle: color))
    }
}

#Preview {
    Text(verbatim: "Hello world")
        .textStyle(TitleTextStyle(foregroundStyle: .default))
}
