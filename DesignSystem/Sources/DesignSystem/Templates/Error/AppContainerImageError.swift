import Foundation
import SwiftUI
import UIKit

public enum AppContainerImageError: Error {
    case typeUndefined
}

public struct AppContainerImage: Hashable, Codable, Sendable {
    
    public let url: URL?
    public let data: Data?
    public let name: String?
    
    public init(url: URL) {
        self.url = url
        self.data = nil
        self.name = nil
    }
    
    public init(data: Data) {
        self.data = data
        self.url = nil
        self.name = nil
    }
    
    public init(name: String) {
        self.name = name
        self.data = nil
        self.url = nil
    }
    
    public func getImage() -> Image {
        if let name {
            return Image(name)
        } else if let data {
            return (try? getImageFrom(data: data)) ?? Image("")
        } else if let url {
            if let data = try? Data(contentsOf: url) {
                return (try? getImageFrom(data: data)) ?? Image("")
            }
        }
        
        return Image("")
    }
    
    public func getUIImage() -> UIImage {
        if let name {
            return UIImage(named: name) ?? UIImage()
        } else if let data {
            return UIImage(data: data) ?? UIImage()
        } else if let url {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data) ?? UIImage()
            }
        }
        
        return UIImage()
    }
    
    public func getImageFrom(data: Data) throws -> Image {
        #if canImport(AppKit)
        guard let nsImage = NSImage(data: data) else {
            throw AppContainerImageError.typeUndefined
        }
        return Image(nsImage: nsImage)
        #elseif canImport(UIKit)
        guard let uiImage = UIImage(data: data) else {
            throw AppContainerImageError.typeUndefined
        }
        return Image(uiImage: uiImage)
        #else
        throw AppContainerImageError.typeUndefined
        #endif
    }
    
    public func getImageFromURLToData() throws -> Image {
        guard let url else {
            throw AppContainerImageError.typeUndefined
        }
        
        let data = try Data(contentsOf: url)
        
        return try getImageFrom(data: data)
    }
}
