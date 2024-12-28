import Foundation

public struct PhotoFilterEffectOption: OptionSet, Sendable {
    public let rawValue: Int
    
    public static let noiseBigger = PhotoFilterEffectOption(rawValue: 1 << 0)
    public static let skinColor = PhotoFilterEffectOption(rawValue: 1 << 1)
    public static let skinBlackDots = PhotoFilterEffectOption(rawValue: 1 << 2)
    
    public static let all: PhotoFilterEffectOption = [.noiseBigger, .skinColor, .skinBlackDots]
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
