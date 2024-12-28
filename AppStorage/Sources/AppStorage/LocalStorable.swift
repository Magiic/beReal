import Foundation

public protocol LocalStorable {
    
    /// Store an object that conforms to `Encodable` protocol
    /// - Parameters:
    ///   - object: Object to store
    ///   - key: Key used to identify the object
    ///   - encoder: An object that encodes instances of a data type as JSON objects.
    func store(_ object: some Encodable, forKey key: String, encoder: JSONEncoder) throws
    
    /// Get an object that conforms to `Decodable` protocol
    /// - Parameters:
    ///   - key: Key used to identify the object
    ///   - decoder: An object that decodes instances of a data type from JSON objects.
    /// - Returns: Object to retrieve
    func get<Decode: Decodable>(key: String, decoder: JSONDecoder) throws -> Decode?
    
    /// Remove an existing object with the specified key
    /// - Parameter key: Key used to identify the object
    func removeItem(forKey key: String) throws
}
