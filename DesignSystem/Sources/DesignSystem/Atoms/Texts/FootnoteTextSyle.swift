import SwiftUI

public struct FootnoteTextSyle<S: ShapeStyle>: TextStyleModifier {
    public let foregroundStyle: AppPlatformShapeStyle<S>
    
    public init(foregroundStyle: AppPlatformShapeStyle<S>) {
        self.foregroundStyle = foregroundStyle
    }
    
    public func body(content: Content) -> some View {
        content
            .font(.footnote)
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
    func footnoteTextStyle(color: AppPlatformShapeStyle<Color> = .default) -> some View {
        modifier(FootnoteTextSyle(foregroundStyle: color))
    }
}

#Preview {
    Text(verbatim: "Hello world")
        .textStyle(FootnoteTextSyle(foregroundStyle: .default))
}
