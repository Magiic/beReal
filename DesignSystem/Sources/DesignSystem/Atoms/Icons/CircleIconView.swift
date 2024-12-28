import SwiftUI

public struct CircleIconView<S: ShapeStyle, T: ShapeStyle>: View {
    public let systemName: String
    public let primaryStyle: AppPlatformShapeStyle<S>
    public let tintStyle: AppPlatformShapeStyle<T>
    public var inset: Double = 8
    
    init(
        systemName: String,
        primaryStyle: AppPlatformShapeStyle<S>,
        tintStyle: AppPlatformShapeStyle<T>,
        inset: Double = 8
    ) {
        self.systemName = systemName
        self.primaryStyle = primaryStyle
        self.tintStyle = tintStyle
        self.inset = inset
    }
    
    public var body: some View {
        Image(systemName: systemName)
            .applyForegroundStyle(primaryStyle)
            .padding(inset)
            .applyBackgroundStyle(tintStyle, in: .circle)
    }
}

#Preview {
    CircleIconView(
        systemName: "xmark",
        primaryStyle: .init(
            iOS: Color.gray,
            visionOS: Color.gray,
            macOS: Color.gray,
            watchOS: Color.gray,
            tvOS: Color.gray
        ),
        
        tintStyle: .init(
            iOS: Color.black,
            visionOS: Color.black,
            macOS: Color.black,
            watchOS: Color.black,
            tvOS: Color.black
        )
    )
}
