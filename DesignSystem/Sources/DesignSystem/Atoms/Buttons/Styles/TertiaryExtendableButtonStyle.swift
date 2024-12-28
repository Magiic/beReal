import SwiftUI

public struct TertiaryExtendableButtonStyle<FS: ShapeStyle, BS: ShapeStyle>: ButtonStyle {
    
    public var foregroundStyle: AppPlatformShapeStyle<FS>
    public var backgroundStyle: AppPlatformShapeStyle<BS>
    private let cornerRadius: Double
    
    public init(
        foregroundStyle: AppPlatformShapeStyle<FS>,
        backgroundStyle: AppPlatformShapeStyle<BS>
    ) {
        self.foregroundStyle = foregroundStyle
        self.backgroundStyle = backgroundStyle
        #if os(visionOS)
        cornerRadius = 20
        #else
        cornerRadius = 6
        #endif
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.body, weight: .bold))
            .applyForegroundStyle(foregroundStyle)
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, alignment: .center)
            .applyRectBackground(shape: backgroundStyle, cornerRadius: cornerRadius)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .contentShape(.interaction, .rect)
            .contentShape(.hoverEffect, .rect(cornerRadius: 16))
            .hoverEffect()
    }
}

#Preview("Tertiary") {
    Button {
        
    } label: {
        Text(verbatim: "Continue")
    }
    .buttonStyle(TertiaryExtendableButtonStyle(foregroundStyle: .init(all: Color.white), backgroundStyle: .init(all: Color.black)))
    .padding(.horizontal)
}
