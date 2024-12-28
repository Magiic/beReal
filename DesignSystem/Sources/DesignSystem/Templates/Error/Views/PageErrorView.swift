import SwiftUI

public struct PageErrorView: View {
    public let imageName: String
    public let title: String
    public let message: String
    public var sizeIcon: Double = 120
    
    public init(
        imageName: String,
        title: String,
        message: String,
        sizeIcon: Double = 120
    ) {
        self.imageName = imageName
        self.title = title
        self.message = message
        self.sizeIcon = sizeIcon
    }
    
    public init(error: ErrorData) {
        self.imageName = error.imageName
        self.title = error.title
        self.message = error.message ?? ""
    }

    public var body: some View {
        VStack(spacing: 16) {

            Image(systemName: imageName)
                .font(.system(size: sizeIcon))

            Text(LocalizedStringKey(title))
                .font(.title2)
                .multilineTextAlignment(.center)

            Text(LocalizedStringKey(message))
                .font(.body)
                .multilineTextAlignment(.center)
        }
        .accessibilityIdentifier("page_error_view")
    }
}

#Preview("Light") {
    PageErrorView(
        imageName: "folder.circle.fill",
        title: "Oops",
        message: "Retry later"
    )
    .padding()
}

#Preview("Dark") {
    PageErrorView(
        imageName: "folder.circle.fill",
        title: "Oops",
        message: "Retry later"
    )
    .preferredColorScheme(.dark)
    .padding()
}
