import AssetSelectionPicker
import DesignSystem
import SwiftUI

struct IllPickerAssetView: View {
    
    @Binding var photoSelected: PhotoPickerState
    
    var body: some View {
        VStack {
            Text("Check that you are ok")
                .largeTitleTextStyle()
                .multilineTextAlignment(.center)
            
            // It is better to use the camera and ask user to take itself a selfie
            // If I have time I will add this feature
            PhotoPickerView(
                imageState: $photoSelected,
                customView: {
                    VStack {
                        switch photoSelected {
                        case .loading:
                            ProgressView()
                        case .success(let data):
                            if let uiimage = UIImage(data: data) {
                                Image(uiImage: uiimage)
                                    .resizable()
                                    .foregroundStyle(Color.primaryApp)
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                            } else {
                                placeholderPicker
                            }
                        case .empty:
                            placeholderPicker
                        case .failure:
                            placeholderPicker
                        }
                        
                        Text("Tap to select a picture")
                            .font(.body)
                            .foregroundStyle(Color.systemGray)
                    }
                }
            )
        }
    }
    
    var placeholderPicker: some View {
        Image(systemName: "photo.circle.fill")
            .resizable()
            .foregroundStyle(Color.primaryApp)
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var photo: PhotoPickerState = .empty
    IllPickerAssetView(photoSelected: $photo)
}
