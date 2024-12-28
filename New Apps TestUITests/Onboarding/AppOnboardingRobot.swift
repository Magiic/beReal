import XCTest
@testable import New_Apps_Test

@MainActor
final class AppOnboardingRobot: Robot {
        
    @discardableResult
    func tapNextButton() -> Self {
        XCTAssertTrue(nextButton().exists)
        nextButton().tap()
        return self
    }
    
    @discardableResult
    func tapPreviousButton() -> Self {
        XCTAssertTrue(previousButton().exists)
        previousButton().tap()
        return self
    }
    
    @discardableResult
    func enter(email: String = "mytest@beill.com") -> Self {
        XCTAssertTrue(emailTextField().exists)
        emailTextField().tap()
        emailTextField().typeText(email)
        return self
    }
    
    @discardableResult
    func checkValidEmail() -> Self {
        XCTAssertTrue(checkmarkValid().exists)
        return self
    }
    
    @discardableResult
    func checkInvalidEmail() -> Self {
        XCTAssertTrue(checkmarkInvalid().exists)
        return self
    }
    
    @discardableResult
    func dismissKeyboard() -> Self {
        let keyboardReturnButton = app.keyboards.buttons["Return"]
        keyboardReturnButton.tap()
        return self
    }
    
    private func nextButton() -> XCUIElement {
        app.buttons["next_button"]
    }
    
    private func previousButton() -> XCUIElement {
        app.buttons["previous_button"]
    }
    
    private func checkmarkValid() -> XCUIElement {
        app.images["checkmark_valid"]
    }
    
    private func checkmarkInvalid() -> XCUIElement {
        app.images["checkmark_invalid"]
    }
    
    private func emailTextField() -> XCUIElement {
        app.textFields["email_textfield"]
    }
}
