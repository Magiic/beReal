import SwiftUI

struct IllPhotoView: View {
    let photo: UIImage
    var size: CGSize = CGSize(width: 280, height: 280)
    
    var body: some View {
        Image(uiImage: photo)
            .resizable()
            .frame(width: size.width, height: size.height)
            .scaledToFit()
            .clipShape(.circle)
            .accessibilityLabel(Text("Sick person face"))
    }
}

#Preview {
    IllPhotoView(photo: UIImage(resource: .onboardingIllustration))
}
