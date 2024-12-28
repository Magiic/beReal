import Foundation

enum EmailValidatorError: Error {
    case invalid
}

/// Allows to validate email entered by user before processing
struct EmailValidator: ValidationThrows {
    
    var validationThrow: ((String) throws -> Void)? = { email in
        let dataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let firstMatch = dataDetector.firstMatch(in: email, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: email.count))
        
        guard let firstMatch else {
            throw EmailValidatorError.invalid
        }
        
        if firstMatch.range.location == NSNotFound || firstMatch.url?.scheme != "mailto" {
            throw EmailValidatorError.invalid
        }
    }
}
