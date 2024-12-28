import SwiftUI

public struct SecondaryButtonStyle<FS: ShapeStyle>: ButtonStyle {
    
    public var foregroundStyle: AppPlatformShapeStyle<FS>
    
    public init(
        foregroundStyle: AppPlatformShapeStyle<FS>
    ) {
        self.foregroundStyle = foregroundStyle
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyForegroundStyle(foregroundStyle)
            #if os(visionOS)
            .font(.title3)
            .padding()
            #else
            .font(.body)
            .fontWeight(.medium)
            #endif
            .contentShape(.interaction, .rect)
            .contentShape(.hoverEffect, .rect(cornerRadius: 12))
            .hoverEffect()
    }
}

#Preview("Secondary") {
    Button {
        
    } label: {
        Text(verbatim: "Continue")
    }
    .buttonStyle(SecondaryButtonStyle(foregroundStyle: .init(all: Color.systemGray)))
}
