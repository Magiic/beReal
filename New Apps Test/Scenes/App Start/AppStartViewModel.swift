import SwiftUI

@MainActor
final class AppStartViewModel: ObservableObject {
    @Published var sceneStartState: AppSceneStartState = .splash
    
    let storage: CurrentUserStorage
    
    init(sceneStartState: AppSceneStartState = .splash, storage: CurrentUserStorage) {
        self.sceneStartState = sceneStartState
        self.storage = storage
    }
    
    func fetchData() async {
        sceneStartState = getCurrentScene()
    }
    
    private func getCurrentScene() -> AppSceneStartState {
        do {
            let currentUser = try storage.get()
            if currentUser.hasSeenOnboarding {
                return .home
            } else {
                return .onboarding
            }
        } catch {
            AppLogger.onboarding.error("Cannot get current user to display home or onboarding \(error)")
            return .onboarding
        }
    }
}
