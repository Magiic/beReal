import AppStorage
import Foundation

extension UserDefaults: @retroactive UserDefaultsProtocol {}
extension UserDefaults: @unchecked @retroactive Sendable {}
