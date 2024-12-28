import DesignSystem
import SwiftUI

struct AppOnboardingPhotoFilteredView: View {
    
    var photo: UIImage
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                
                IllResultView(photo: photo)
                
                IllSharingView(
                    text: String(localized: "Don't panic. First, let your friends and family know about your symptoms. Tell them they can use the app to check their health."),
                    photo: photo
                )
                
                MedicinesInformativeView(isShowingPaywallButton: false)
            }
        }
        .padding(.horizontal, 16)
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var email = ""
    AppOnboardingPhotoFilteredView(photo: UIImage(resource: .onboardingIllustration))
}
