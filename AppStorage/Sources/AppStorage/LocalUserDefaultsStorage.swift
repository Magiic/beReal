import Foundation

public final class LocalUserDefaultsStorage: LocalStorable {
    
    private let userDefaults: UserDefaultsProtocol
    
    public init(userDefaults: UserDefaultsProtocol) {
        self.userDefaults = userDefaults
    }
    
    public func store(_ object: some Encodable, forKey key: String, encoder: JSONEncoder) throws {
        let data = try encoder.encode(object)
        userDefaults.set(data, forKey: key)
    }
    
    public func get<Decode: Decodable>(key: String, decoder: JSONDecoder) throws -> Decode? {
        guard let value = userDefaults.value(forKey: key) as? Data else {
            return nil
        }
        
        return try decoder.decode(Decode.self, from: value)
    }
    
    public func removeItem(forKey key: String) throws {
        userDefaults.removeObject(forKey: key)
    }
}
