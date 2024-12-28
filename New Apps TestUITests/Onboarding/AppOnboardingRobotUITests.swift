import XCTest

@MainActor
final class AppOnboardingRobotUITests: XCTestCase {

    private var onboardingRobot: AppOnboardingRobot!

    func testHappyPath() throws {
        let app = XCUIApplication()
        onboardingRobot = AppOnboardingRobot(app: app)
        app.launch()
        
        let photoPickerRobot = PhotoPickerRobot(app: app)
        
        onboardingRobot
            .tapNextButton()
            .enter(email: "mytest@beill.com")
            .checkValidEmail()
            .dismissKeyboard()
            .tapNextButton()
        
        photoPickerRobot
            .tapPhotoPicker()
            .selectFirstPhoto()
        
        onboardingRobot
            .tapNextButton()
    }
}
