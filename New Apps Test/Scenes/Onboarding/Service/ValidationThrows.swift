import Foundation

protocol ValidationThrows {
    
    associatedtype T
    
    var validationThrow: ((T) throws -> Void)? { get set }
}

protocol Validation {
    
    associatedtype T
    
    var validation: ((T) -> Bool)? { get set }
}
