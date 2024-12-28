import SwiftUI

public struct PrimaryButtonStyle<FS: ShapeStyle>: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled
    
    public var foregroundStyle: AppPlatformShapeStyle<FS>
    public var backgroundColor: Color
    
    public init(
        foregroundStyle: AppPlatformShapeStyle<FS>,
        backgroundColor: Color
    ) {
        self.foregroundStyle = foregroundStyle
        self.backgroundColor = backgroundColor
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.body, weight: .bold))
            .applyForegroundStyle(foregroundStyle)
            .padding(.vertical, 16)
            .padding(.horizontal, 64)
            .background(
                Capsule()
                    .foregroundStyle(isEnabled ? backgroundColor : backgroundColor.opacity(0.5))
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .contentShape(.hoverEffect, .capsule)
            .hoverEffect()
    }
}

#Preview("Enable") {
    Button {
        
    } label: {
        Text(verbatim: "Continue")
    }
    .buttonStyle(PrimaryButtonStyle(foregroundStyle: .init(all: Color.white), backgroundColor: Color.blue))
}

#Preview("Disabled") {
    Button {
        
    } label: {
        Text(verbatim: "Continue")
    }
    .buttonStyle(PrimaryButtonStyle(foregroundStyle: .init(all: Color.white), backgroundColor: Color.blue))
    .disabled(true)
}
