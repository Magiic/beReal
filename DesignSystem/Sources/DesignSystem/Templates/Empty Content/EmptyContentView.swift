import SwiftUI

public struct EmptyContentView: View {
    
    public let content: EmptyContentViewData
    
    public init(content: EmptyContentViewData) {
        self.content = content
    }
    
    public var body: some View {
        mainContainer()
    }
    
    @ViewBuilder
    private func mainContainer() -> some View {
        if #available(iOS 17.0, *) {
            if content.description != nil {
                ContentUnavailableView(label: {
                    label()
                }, description: {
                    description()
                }, actions: {
                    button()
                })
                .padding(8)
                .background(Color.systemGray5.clipShape(.rect(cornerRadius: 8)))
            } else {
                ContentUnavailableView {
                    label()
                } actions: {
                    button()
                }
            }
            
        } else {
            Button {
                content.action.tap()
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .foregroundStyle(Color.systemGray5)
                        .cornerRadius(12)
                    
                    VStack(spacing: 8) {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                        
                        if let text = content.text {
                            Text(text)
                        }
                    }
                    .foregroundStyle(.primary)
                    .padding()
                }
            }
            .background(Color.systemGray5)
            .cornerRadius(20)
            .accessibilityIdentifier("empty_content_view")
        }
    }
    
    @available(iOS 17, *)
    @ViewBuilder
    private func label() -> some View {
        if let iconName = content.iconName {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                if let text = content.text {
                    Text(text)
                        .lineLimit(3)
                }
            }
            .padding(.bottom, content.text == nil && content.description == nil ? 8 : 0) // Have space between icon and action button if no title and description
        } else {
            EmptyView()
        }
    }
    
    @available(iOS 17, *)
    @ViewBuilder
    private func description() -> some View {
        if let description = content.description {
            Text(description)
        } else {
            EmptyView()
        }
    }
    
    @available(iOS 17, *)
    private func button() -> some View {
        Button(action: {
            content.action.tap()
        }) {
            if let icon = content.action.iconName {
                Label {
                    Text(content.action.title)
                        .lineLimit(1)
                } icon: {
                    Image(systemName: icon)
                }
            } else {
                Text(content.action.title)
                    .lineLimit(1)
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview("Light") {
    EmptyContentView(
        content: .init(
            text: "Send a mail",
            description: "Send a new mail to share your feedback",
            iconName: "mail",
            action: .init(
                title: "Refresh",
                iconName: "play",
                tap: {}
            )
        )
    )
    .frame(width: .infinity, height: 200)
    .padding()
}

#Preview("Card Dark") {
    EmptyContentView(
        content: .init(
            text: "",
            description: "Contact the support",
            iconName: "phone",
            action: .init(
                title: LocalizedStringResource("Add"),
                iconName: nil,
                tap: {}
            )
        )
    )
    .frame(width: 140, height: 190)
    .padding()
    .preferredColorScheme(.dark)
}
