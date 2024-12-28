import SwiftUI

public struct CircleLargeIconButtonStyle<T: ShapeStyle>: ButtonStyle {
    public let systemName: String
    public let tintStyle: AppPlatformShapeStyle<T>
    
    public init(systemName: String, tintStyle: AppPlatformShapeStyle<T>) {
        self.systemName = systemName
        self.tintStyle = tintStyle
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        CircleLargeIconView(systemName: systemName, tintStyle: tintStyle)
            .contentShape(.interaction, .circle)
            .contentShape(.hoverEffect, CircleSizeShape(size: .init(width: 50, height: 50)))
            .hoverEffect()
    }
}

#Preview {
    Button("") {}
        .buttonStyle(CircleLargeIconButtonStyle(systemName: "xmark", tintStyle: .init(all: Color.systemGray)))
}
