import Foundation

public protocol UserDefaultsProtocol: Sendable {
    
    func set(_ value: Any?, forKey defaultName: String)
    
    func value(forKey key: String) -> Any?
    
    func bool(forKey defaultName: String) -> Bool
    
    func object(forKey defaultName: String) -> Any?
    
    func string(forKey defaultName: String) -> String?
    
    func integer(forKey defaultName: String) -> Int
    
    func double(forKey defaultName: String) -> Double
    
    func removeObject(forKey defaultName: String)
}
