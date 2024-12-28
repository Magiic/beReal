import SwiftUI

struct AppStartView: View {
    @StateObject var viewModel = AppStartViewModel(storage: AppCurrentUserStorage())
    
    var body: some View {
        VStack {
            switch viewModel.sceneStartState {
            case .splash:
                EmptyView()
            case .home:
                RootView()
            case .onboarding:
                AppOnboardingView(userAction: $viewModel.sceneStartState)
            }
        }
        .environment(\.purchaseManager, PurchaseManager(userStorage: AppCurrentUserStorage()))
        .environment(\.paywallAnalytics, AppPaywallAnalytics())
        .environment(\.userPhotoStorage, AppUserPhotoStorage())
        .environment(\.currentUserStorage, viewModel.storage)
        .environment(\.photoFilterManager, AppPhotoFilterManager())
        .task {
            await viewModel.fetchData()
        }
    }
}

#Preview {
    AppStartView()
}
