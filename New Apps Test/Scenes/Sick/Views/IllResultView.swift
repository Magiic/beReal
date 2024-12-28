import SwiftUI

struct IllResultView: View {
    
    let photo: UIImage
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            
            Text("You are ill")
                .largeTitleTextStyle()
            
            IllPhotoView(photo: photo)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    IllResultView(photo: UIImage(resource: .onboardingIllustration))
}
