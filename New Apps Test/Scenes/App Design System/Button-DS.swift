import DesignSystem
import SwiftUI

extension ButtonStyle where Self == PrimaryButtonStyle<Color> {
    
    /// Default style `PrimaryButtonStyle`
    static var `default`: Self {
        PrimaryButtonStyle(
            foregroundStyle: .init(all: .primaryInvert),
            backgroundColor: .primaryApp
        )
    }
}

extension ButtonStyle where Self == PrimaryExtendableButtonStyle<Color> {
    
    /// Default style `PrimaryExtendableButtonStyle`
    static var `default`: Self {
        PrimaryExtendableButtonStyle(
            foregroundStyle: .init(all: .primaryInvert),
            backgroundColor: .primaryApp
        )
    }
}

// MARK: - Secondary

extension ButtonStyle where Self == SecondaryButtonStyle<Color> {
    
    /// Default style `SecondaryButtonStyle`
    static var `default`: Self {
        SecondaryButtonStyle(
            foregroundStyle: .init(all: Color.systemGray)
        )
    }
}

// MARK: - Tertiary

extension ButtonStyle where Self == TertiaryButtonStyle<Color, Color> {
    
    /// Default style `TertiaryButtonStyle`
    static var `default`: Self {
        TertiaryButtonStyle(
            foregroundStyle: .init(all: .primaryInvert),
            backgroundStyle: .init(all: .primaryApp)
        )
    }
}

extension ButtonStyle where Self == TertiaryExtendableButtonStyle<Color, Color> {
    
    /// Default style `TertiaryExtendableButtonStyle`
    static var `default`: Self {
        TertiaryExtendableButtonStyle(
            foregroundStyle: .init(all: .primaryInvert),
            backgroundStyle: .init(all: .primaryApp)
        )
    }
}

// MARK: - Circle Icon Button

extension ButtonStyle where Self == CircleLargeIconButtonStyle<Color> {
    
    /// Default style `CircleLargeIconButtonStyle`
    static func `default`(systemName: String) -> Self {
        CircleLargeIconButtonStyle(
            systemName: systemName,
            tintStyle: .init(all: Color.systemGray)
        )
    }
}

extension ButtonStyle where Self == CircleIconButtonStyle<Color, Color> {
    
    /// Default style `CircleIconButtonStyle`
    static func `default`(systemName: String) -> Self {
        CircleIconButtonStyle(
            systemName: systemName,
            primaryStyle: .init(all: .primaryInvert),
            tintStyle: .init(all: .primaryApp)
        )
    }
}

extension ButtonStyle where Self == ShareCircleLargeIconButtonStyle<Color> {
    
    /// Default style `PrimaryButtonStyle`
    static var `default`: Self {
        ShareCircleLargeIconButtonStyle(tintStyle: .init(all: .primaryApp))
    }
}
