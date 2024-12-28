import CoreTransferable
import Foundation
import SwiftUI

public struct AssetPickerTransferImage: Transferable, Sendable {
    public let data: Data
    var image: Image {
        get throws {
#if canImport(AppKit)
    guard let nsImage = NSImage(data: data) else {
        throw AssetPickerError.importFailed
    }
    let image = Image(nsImage: nsImage)
    return image
#elseif canImport(UIKit)
    guard let uiImage = UIImage(data: data) else {
        throw AssetPickerError.importFailed
    }
    let image = Image(uiImage: uiImage)
    return image
#else
    throw AssetPickerError.importFailed
#endif
        }
    }
    
    public static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            AssetPickerTransferImage(data: data)
        }
    }
}
