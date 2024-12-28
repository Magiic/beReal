import SwiftUI

public protocol TextStyleModifier: ViewModifier {}

public extension View {
    
    /// Specifies Text Style
    func textStyle<Style: TextStyleModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
