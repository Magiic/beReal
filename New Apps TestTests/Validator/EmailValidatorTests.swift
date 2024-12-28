import Testing
@testable import New_Apps_Test

@Suite("Email Validation")
struct EmailValidatorTests {
    
    @Test("Should be successfull when the email is correct")
    func goodEmail() throws {
        let email = "goodone@beill.com"
        let emailValidator = EmailValidator()
        
        #expect(throws: Never.self, performing: {
            try emailValidator.validationThrow?(email)
        })
    }
    
    @Test("Should be throw invalid email", arguments: ["goodonebeill.com", "goodonebeillcom"])
    func invalidEmail(email: String) throws {
        let emailValidator = EmailValidator()
        
        #expect(throws: EmailValidatorError.self) {
            try emailValidator.validationThrow?(email)
        }
    }
}
