import Foundation

public struct ButtonPageErrorAction: Identifiable {
    public let id: Int
    public let titleButton: String
    public let action: () -> Void

    public init(id: Int, titleButton: String, action: @escaping () -> Void) {
        self.id = id
        self.titleButton = titleButton
        self.action = action
    }
}
