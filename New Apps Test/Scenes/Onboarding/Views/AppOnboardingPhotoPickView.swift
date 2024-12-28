import AssetSelectionPicker
import DesignSystem
import SwiftUI
import PhotosUI

struct AppOnboardingPhotoPickView: View {
    @Binding var photoSelected: PhotoPickerState
    
    var body: some View {
        IllPickerAssetView(photoSelected: $photoSelected)
            .padding(.horizontal)
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityIdentifier("photo_picker")
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var photo: PhotoPickerState = .empty
    AppOnboardingPhotoPickView(photoSelected: $photo)
}
