import DesignSystem
import SwiftUI

struct AppOnboardingResumeView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    let analytics: OnboardingAnalytics
    
    var body: some View {
        VStack(spacing: 16) {
            if verticalSizeClass == .regular {
                portraitMode()
            } else {
                landscapeMode()
            }
        }
        .edgesIgnoringSafeArea([.horizontal, .top])
        .onAppear {
            analytics.screenResume()
        }
    }
    
    private func landscapeMode() -> some View {
        HStack(spacing: 16) {
            imageView()
                .frame(maxWidth: 200, maxHeight: .infinity)
                .clipped()
            
            textsView()
                .padding(.horizontal, 100)
        }
    }
    
    private func portraitMode() -> some View {
        VStack(spacing: 16) {
            imageView()
                .frame(maxWidth: .infinity, maxHeight: 280)
                .clipped()
            
            textsView()
                .padding(.horizontal, 16)

            Spacer()
        }
    }
    
    private func imageView() -> some View {
        Image("onboarding_illustration")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    private func textsView() -> some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.primaryApp)
                }
                
                VStack(spacing: 4) {
                    Text("BeILL")
                        .font(.title3)
                        .bold()
                    
                    Text("Are you sick?")
                        .font(.system(.subheadline, design: .default, weight: .light))
                }
                .padding(.bottom, 8)
                
                HStack(alignment: .center, spacing: 2) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.primaryApp)
                }
            }
            
            descContent()
        }
    }
    
    private func descContent() -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Since December 27, 2024, a virus of unknown origin has been spreading around the world. Anyone using the BeReal app will experience swelling in their nose, eyes, or mouth if they are infected with this virus.")
            
            Text("The app is able to detect the effects of the virus before they physically appear. Use the app to check that you are not sick.")
        }
        .bodyTextStyle()
    }
}

#Preview {
    AppOnboardingResumeView(analytics: AppOnboardingAnalyticsSpy())
}
