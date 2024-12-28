import SwiftUI

public struct BackgroundRectComponentViewModifier<FS: ShapeStyle>: ViewModifier {
    
    public var foregroundStyle: FS
    public var cornerRadius: Double
    
    public init(foregroundStyle: FS, cornerRadius: Double) {
        self.foregroundStyle = foregroundStyle
        self.cornerRadius = cornerRadius
    }
    
    public func body(content: Content) -> some View {
        if #available(iOS 17, *) {
            content
                .background(foregroundStyle, in: .rect(cornerRadius: cornerRadius))
        } else {
            content
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundStyle(foregroundStyle)
                )
        }
    }
}

public extension View {
    
    @ViewBuilder
    func applyRectBackground<Shape: ShapeStyle>(shape: AppPlatformShapeStyle<Shape>, cornerRadius: Double = 6) -> some View {
        #if os(visionOS)
        modifier(BackgroundRectComponentViewModifier(foregroundStyle: shape.visionOS, cornerRadius: cornerRadius))
        #elseif os(iOS)
        modifier(BackgroundRectComponentViewModifier(foregroundStyle: shape.iOS, cornerRadius: cornerRadius))
        #elseif os(macOS)
        modifier(BackgroundRectComponentViewModifier(foregroundStyle: shape.macOS, cornerRadius: cornerRadius))
        #elseif os(tvOS)
        modifier(BackgroundRectComponentViewModifier(foregroundStyle: shape.tvOS, cornerRadius: cornerRadius))
        #elseif os(watchOS)
        modifier(BackgroundRectComponentViewModifier(foregroundStyle: shape.watchOS, cornerRadius: cornerRadius))
        #else
        modifier(BackgroundRectComponentViewModifier(foregroundStyle: shape.iOS, cornerRadius: cornerRadius))
        #endif
    }
}

#Preview {
    Text(verbatim: "Hello world!")
        .padding()
        .foregroundStyle(Color.red)
        .applyRectBackground(shape: .init(all: Color.yellow))
}
