import Foundation
import SwiftUI
import PhotosUI

/// Button to select an asset from the photos library
public struct PhotoPickerView<V: View>: View {
    
    /// Contains the image state
    @Binding public var imageState: PhotoPickerState
    
    public var matching: [PHPickerFilter] = [.images]
    public var customView: @Sendable () -> V
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    public init(
        imageState: Binding<PhotoPickerState>,
        matching: [PHPickerFilter] = [.images],
        customView: @Sendable @escaping () -> V
    ) {
        self._imageState = imageState
        self.matching = matching
        self.customView = customView
    }
    
    public var body: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .all(of: matching),
            label: customView
        )
        .onChange(of: selectedItem) { newItem in
            if let selectedItem {
                let progress = loadTransferable(from: selectedItem)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        imageSelection.loadTransferable(type: AssetPickerTransferImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.selectedItem else {
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.data)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

#Preview {
    PhotoPickerView(
        imageState: .constant(.empty),
        customView: { Text(verbatim: "Select picture")
        }
    )
}
