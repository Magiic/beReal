import SwiftUI

public struct CircleIconButtonStyle<S: ShapeStyle, T: ShapeStyle>: ButtonStyle {
    public let systemName: String
    public let primaryStyle: AppPlatformShapeStyle<S>
    public let tintStyle: AppPlatformShapeStyle<T>
    
    public init(
        systemName: String,
        primaryStyle: AppPlatformShapeStyle<S>,
        tintStyle: AppPlatformShapeStyle<T>
    ) {
        self.systemName = systemName
        self.primaryStyle = primaryStyle
        self.tintStyle = tintStyle
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        CircleIconView(
            systemName: systemName,
            primaryStyle: primaryStyle,
            tintStyle: tintStyle
        )
        .contentShape(.interaction, .circle)
        .contentShape(.hoverEffect, .circle)
        .hoverEffect()
    }
}

#Preview {
    Button("", action: {})
        .buttonStyle(
            CircleIconButtonStyle(
                systemName: "xmark",
                primaryStyle: .init(
                    iOS: Color.white,
                    visionOS: Color.white,
                    macOS: Color.white,
                    watchOS: Color.white,
                    tvOS: Color.white
                ),
                tintStyle: .init(
                    iOS: Color.purple,
                    visionOS: Color.purple,
                    macOS: Color.purple,
                    watchOS: Color.purple,
                    tvOS: Color.purple
                )
            )
        )
}
