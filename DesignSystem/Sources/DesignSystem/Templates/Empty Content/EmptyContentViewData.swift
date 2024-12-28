import Foundation

public struct EmptyContentViewData {
    
    public struct Action {
        public let title: LocalizedStringResource
        public let iconName: String?
        public let tap: () -> Void
        
        public init(
            title: LocalizedStringResource,
            iconName: String?,
            tap: @escaping () -> Void
        ) {
            self.title = title
            self.iconName = iconName
            self.tap = tap
        }
    }
    
    public init(
        text: LocalizedStringResource?,
        description: LocalizedStringResource?,
        iconName: String?,
        action: EmptyContentViewData.Action
    ) {
        self.text = text
        self.description = description
        self.iconName = iconName
        self.action = action
    }
    
    public let text: LocalizedStringResource?
    public let description: LocalizedStringResource?
    public let iconName: String?
    public let action: EmptyContentViewData.Action
}
