import SwiftUI

public struct PageErrorButtonsView<FS: ShapeStyle>: View {
    public var iconName: String = "xmark.circle.fill"
    public let title: String?
    public let message: String
    public let buttons: [ButtonPageErrorAction]
    public var foregroundStyle: AppPlatformShapeStyle<FS>
    public var backgroundColor: Color
    
    public init(
        iconName: String,
        title: String?,
        message: String,
        buttons: [ButtonPageErrorAction],
        foregroundStyle: AppPlatformShapeStyle<FS>,
        backgroundColor: Color
    ) {
        self.iconName = iconName
        self.title = title
        self.message = message
        self.buttons = buttons
        self.foregroundStyle = foregroundStyle
        self.backgroundColor = backgroundColor
    }
    
    public init(
        error: ErrorData,
        buttons: [ButtonPageErrorAction],
        foregroundStyle: AppPlatformShapeStyle<FS>,
        backgroundColor: Color
    ) {
        self.iconName = error.imageName
        self.title = error.title
        self.message = error.message ?? ""
        self.buttons = buttons
        self.foregroundStyle = foregroundStyle
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        VStack(alignment: .center, spacing: 8) {

            Image(systemName: iconName)
                .foregroundColor(.primary)
                .font(.system(size: 90, weight: .medium, design: .rounded))

            Text(title ?? "generic_title_error")
                .font(.system(size: 28, weight: .bold, design: .default))
                .foregroundColor(.label)

            Text(message)
                .foregroundColor(.label)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)

            ForEach(buttons) { buttonAction in
                Button(action: {
                    buttonAction.action()
                }, label: {
                    Text(buttonAction.titleButton)
                })
                .font(.system(size: 22, weight: .medium, design: .rounded))
                .applyForegroundStyle(foregroundStyle)
                .buttonStyle(PrimaryButtonStyle(foregroundStyle: foregroundStyle, backgroundColor: backgroundColor))
                .padding(.vertical, 8)
            }
        }
    }
}

#Preview("1 button in Light") {
    PageErrorButtonsView(
        iconName: "xmark.circle.fill",
        title: "Oh no!",
        message: "Retry later",
        buttons: [
            ButtonPageErrorAction(
                id: 1,
                titleButton: "Continue",
                action: {}
            )
        ],
        foregroundStyle: .default,
        backgroundColor: Color.red
    )
}

#Preview("2 buttons in Dark") {
    PageErrorButtonsView(
        iconName: "xmark.circle.fill",
        title: "Oh no!",
        message: "Retry later",
        buttons: [
            ButtonPageErrorAction(
                id: 1,
                titleButton: "Retry",
                action: {}
            ),
            ButtonPageErrorAction(
                id: 2,
                titleButton: "Open Settings",
                action: {}
            )
        ],
        foregroundStyle: .default,
        backgroundColor: Color.red
    )
    .preferredColorScheme(.dark)
}
