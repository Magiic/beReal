import SwiftUI

public struct LargeTitleTextSyle<S: ShapeStyle>: TextStyleModifier {
    public let foregroundStyle: AppPlatformShapeStyle<S>
    
    public init(foregroundStyle: AppPlatformShapeStyle<S>) {
        self.foregroundStyle = foregroundStyle
    }
    
    public func body(content: Content) -> some View {
        content
            #if os(visionOS)
            .foregroundStyle(foregroundStyle.visionOS)
            .font(.extraLargeTitle)
            #elseif os(iOS)
            .foregroundStyle(foregroundStyle.iOS)
            .font(.largeTitle)
            #elseif os(macOS)
            .foregroundStyle(foregroundStyle.macOS)
            .font(.largeTitle)
            #elseif os(tvOS)
            .foregroundStyle(foregroundStyle.tvOS)
            .font(.largeTitle)
            #elseif os(watchOS)
            .foregroundStyle(foregroundStyle.watchOS)
            .font(.largeTitle)
            #else
            .foregroundStyle(foregroundStyle.iOS)
            .font(.largeTitle)
            #endif
    }
}

public extension View {
    func largeTitleTextStyle(color: AppPlatformShapeStyle<Color> = .default) -> some View {
        modifier(LargeTitleTextSyle(foregroundStyle: color))
    }
}

#Preview {
    Text(verbatim: "Hello world")
        .textStyle(LargeTitleTextSyle(foregroundStyle: .default))
}
