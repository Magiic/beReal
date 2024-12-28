import Foundation
import SwiftUI
import PhotosUI

/// Represents the state of the photo picking process.
///
/// This enum encapsulates various phases of photo selection or loading,
/// ## Enum Cases:
/// | Case                      | Description                                                                 | Associated Value | Example Usage |
/// |---------------------------|-----------------------------------------------------------------------------|------------------|----------------|
/// | `.loading(Progress)`       | The photo is being loaded, tracking the loading progress.                   | `Progress`       | `PhotoPickerState.loading(Progress())` |
/// | `.success(Data)`           | The photo was successfully selected or loaded, returning image data.        | `Data`           | `PhotoPickerState.success(imageData)`  |
/// | `.empty`                   | No photo was selected or returned by the picker.                           | `None`           | `PhotoPickerState.empty`               |
/// | `.failure(Error)`          | An error occurred during the photo picking or loading process.
/// `Equatable` to enable easy comparison between states and `Sendable`
public enum PhotoPickerState: Equatable, Sendable {
    
    /// The photo is currently being loaded.
    ///
    /// - Parameter progress: A `Progress` object representing the current loading progress.
    case loading(Progress)
    
    /// The photo was successfully loaded.
    ///
    /// - Parameter data: The image data (`Data`) representing the selected photo.
    case success(Data)
    
    /// No photo was selected or the picker returned no results.
    case empty
    
    /// An error occurred during the photo picking process.
    ///
    /// - Parameter error: The error that occurred (`Error`).
    case failure(Error)
    
    public static func == (lhs: PhotoPickerState, rhs: PhotoPickerState) -> Bool {
        if case .empty = lhs, case .empty = rhs {
            return true
        } else if case .success(let luIImage) = lhs, case .success(let ruIImage) = rhs {
            return luIImage == ruIImage
        } else if case .loading(let lProgress) = lhs, case .loading(let rProgress) = rhs {
            return lProgress == rProgress
        } else if case .failure(_) = lhs, case .failure(_) = rhs {
            return true
        } else {
            return false
        }
    }
}
