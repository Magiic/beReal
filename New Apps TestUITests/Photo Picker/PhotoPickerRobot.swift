import XCTest
@testable import New_Apps_Test

@MainActor
final class PhotoPickerRobot: Robot {
    
    @discardableResult
    func tapPhotoPicker() -> Self {
        XCTAssertTrue(photoPickerButton().exists)
        photoPickerButton().tap()
        return self
    }
    
    @discardableResult
    func selectFirstPhoto() -> Self {
        let photoPicker = app.collectionViews.firstMatch
        XCTAssertTrue(photoPicker.waitForExistence(timeout: 5), "Photo Picker did not appear")
        
        let firstPhoto = photoPicker.cells.element(boundBy: 0)
        XCTAssertTrue(firstPhoto.waitForExistence(timeout: 5), "First photo not found")
        firstPhoto.tap()
        return self
    }
    
    private func photoPickerButton() -> XCUIElement {
        app.buttons["photo_picker"]
    }
}
