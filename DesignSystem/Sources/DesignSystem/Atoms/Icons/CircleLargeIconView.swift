import SwiftUI

public struct CircleLargeIconView<S: ShapeStyle>: View {
    public let systemName: String
    public let tintStyle: AppPlatformShapeStyle<S>
    
    public init(systemName: String, tintStyle: AppPlatformShapeStyle<S>) {
        self.systemName = systemName
        self.tintStyle = tintStyle
    }
    
    public var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .bold()
            .padding(8)
            .applyBackgroundStyle(
                tintStyle,
                in: .circle
            )
    }
}

#Preview {
    CircleLargeIconView(
        systemName: "xmark",
        tintStyle: .init(all: Color.systemGray)
    )
}

