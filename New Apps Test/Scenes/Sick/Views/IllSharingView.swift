import DesignSystem
import SwiftUI

struct IllSharingView: View {
    let text: String
    let photo: UIImage
    @State private var isSharing: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text(text)
                .multilineTextAlignment(.leading)
            
            Button {
                isSharing.toggle()
            } label: {
                Text(verbatim: "")
            }
            .buttonStyle(ShareCircleLargeIconButtonStyle.default)
        }
        .padding()
        .background(Color.systemGray6, in: .rect(cornerRadius: 8))
        .sheet(isPresented: $isSharing) {
            ShareActivityView(activityItems: [photo, "I'm sick"])
        }
    }
}

#Preview {
    IllSharingView(
        text: "Don't panic. First, let your friends and family know about your symptoms. Tell them they can use the app to check their health.",
        photo: UIImage(resource: .onboardingIllustration)
    )
    .padding()
}
