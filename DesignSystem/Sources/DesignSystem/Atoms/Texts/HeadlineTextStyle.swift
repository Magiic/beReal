import SwiftUI

public struct HeadlineTextStyle<S: ShapeStyle>: TextStyleModifier {
    public let foregroundStyle: AppPlatformShapeStyle<S>
    
    public init(foregroundStyle: AppPlatformShapeStyle<S>) {
        self.foregroundStyle = foregroundStyle
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.headline)
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
    func headlineTextStyle(color: AppPlatformShapeStyle<Color> = .default) -> some View {
        modifier(HeadlineTextStyle(foregroundStyle: color))
    }
}

#Preview {
    Text(verbatim: "Hello world")
        .textStyle(HeadlineTextStyle(foregroundStyle: .default))
}
