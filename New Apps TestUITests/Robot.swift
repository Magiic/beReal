import Foundation
import XCTest

class Robot {
    
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
        app.launchArguments = ["uitest_run"]
    }
    
    func localized(_ key: String) -> String {
        let testBundle = Bundle(for: type(of: self))
        return NSLocalizedString(key, bundle: testBundle, comment: "")
    }
}
