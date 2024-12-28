import Foundation

public protocol AppErrorDisplayable: Error, Equatable, Identifiable, Sendable {
    var title: String { get }
    var message: String? { get }
    var code: Int { get }
    var image: AppContainerImage? { get }
}

public extension AppErrorDisplayable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.code == rhs.code
    }
}
