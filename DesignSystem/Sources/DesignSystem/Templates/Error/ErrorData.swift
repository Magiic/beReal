import Foundation

public struct ErrorData: Identifiable, Equatable, Sendable {
    public var title: String
    public var message: String?
    public var id: Int
    public var image: AppContainerImage?
    
    public var imageName: String { image?.name ?? "xmark" }
    
    public init(
        title: String,
        message: String? = nil,
        id: Int,
        image: AppContainerImage? = nil
    ) {
        self.title = title
        self.message = message
        self.id = id
        self.image = image
    }
    
    public init<Err: AppErrorDisplayable>(error: Err) {
        self.title = error.title
        self.message = error.message
        self.id = error.code
        self.image = error.image
    }
}
