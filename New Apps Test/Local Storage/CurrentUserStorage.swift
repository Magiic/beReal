import AppStorage
import Foundation

protocol CurrentUserStorage: Sendable {
    
    /// Store current user information
    /// - Parameter user: Current user to store
    func store(user: CurrentUser) throws
    
    /// Get the current user information
    /// - Returns: Current user
    func get() throws -> CurrentUser
}

/// Used to get the current user information or store the updated information
struct AppCurrentUserStorage: CurrentUserStorage {
    private let key = "currentUser"
    
    /// Store current user information
    /// - Parameter user: Current user to store
    func store(user: CurrentUser) throws {
        let storage = LocalUserDefaultsStorage(userDefaults: UserDefaults.standard)
        
        try storage.store(user, forKey: key, encoder: JSONEncoder())
    }
    
    /// Get the current user information
    /// - Returns: Current user
    func get() throws -> CurrentUser {
        let storage = LocalUserDefaultsStorage(userDefaults: UserDefaults.standard)
        
        let user: CurrentUser? = try storage.get(key: key, decoder: JSONDecoder())
        
        return user ?? CurrentUser()
    }
}
