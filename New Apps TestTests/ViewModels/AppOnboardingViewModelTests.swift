import AssetSelectionPicker
import Testing
import PhotoFilterService
import UIKit
@testable import New_Apps_Test

@MainActor
@Suite("Onboarding")
struct AppOnboardingViewModelTests {
    
    private struct FilterServiceSpy: PhotoFilterService {
        func applyDistortion(toImageData data: Data, effects: PhotoFilterEffectOption) async throws -> UIImage? {
            UIImage(resource: .onboardingIllustration)
        }
        
        func applyDistortion(to image: UIImage, effects: PhotoFilterEffectOption) async throws -> UIImage {
            UIImage(resource: .onboardingIllustration)
        }
    }
    
    private struct FilterServiceErrorSpy: PhotoFilterService {
        func applyDistortion(toImageData data: Data, effects: PhotoFilterEffectOption) async throws -> UIImage? {
            throw PhotoFilterServiceError.noFaces
        }
        
        func applyDistortion(to image: UIImage, effects: PhotoFilterEffectOption) async throws -> UIImage {
            throw PhotoFilterServiceError.noFaces
        }
    }
    
    final class CurrentUserStorageSpy: CurrentUserStorage {
        nonisolated(unsafe) var userSpy: CurrentUser = CurrentUser()
        
        func store(user: CurrentUser) throws {
            userSpy = user
        }
        
        func get() throws -> CurrentUser {
            userSpy
        }
    }
    
    final class UserPhotoStorageSpy: UserPhotoStorage {
        nonisolated(unsafe) var collection: UserPhotoCollection = UserPhotoCollection(photos: [])
        
        func storePhotoFiltered(photo: UIImage) async throws {
            guard let data = photo.pngData() else {
                return
            }
            
            collection.photos.append(UserPhoto(id: UUID(), photo: data, date: Date()))
        }
        
        func fetch() async throws -> UserPhotoCollection {
            collection
        }
    }
    
    let currentUserStorage = CurrentUserStorageSpy()
    
    let viewModel = AppOnboardingViewModel(
        analytics: AppOnboardingAnalytics(),
        filterService: FilterServiceSpy(),
        storage: UserPhotoStorageSpy()
    )
    
    @Test("Previous button should not display in first screen")
    func previousButton_ShouldNot_Display() {
        #expect(viewModel.currentIndex == 0)
        #expect(viewModel.showPreviousButton == false)
    }
    
    @Test("Previous button should display for all screens except the second one")
    func previousButton_Should_Display() async {
        
        #expect(viewModel.currentIndex == 0)
        #expect(viewModel.showPreviousButton == false)
        
        await viewModel.next(currentUserStorage: currentUserStorage)
        
        #expect(viewModel.showPreviousButton == true)
        #expect(viewModel.currentIndex == 1)
    }
    
    @Test("Previous button should update current index to 0")
    func previousButton_Should_DecreaseCurrentIndex() async {
        
        #expect(viewModel.currentIndex == 0)
        
        await viewModel.next(currentUserStorage: currentUserStorage)
        
        #expect(viewModel.currentIndex == 1)
        
        viewModel.previous()
        
        #expect(viewModel.currentIndex == 0)
    }
    
    @Test("Next button should increase current index")
    func nextButton_Should_IncreaseCurrentIndex() async {
        
        #expect(viewModel.currentIndex == 0)
        
        await viewModel.next(currentUserStorage: currentUserStorage)
        
        #expect(viewModel.currentIndex == 1)
    }
    
    @Test("Tap next should trigger navigation until home page")
    func tapNext_ShouldTriggerNavigation() async throws {
        
        #expect(viewModel.currentIndex == 0)
        #expect(currentUserStorage.userSpy.hasSeenOnboarding == false)
        
        await viewModel.next(currentUserStorage: currentUserStorage)
        await viewModel.next(currentUserStorage: currentUserStorage)
        
        viewModel.photo = .success(UserPhoto.fake.photo)
        await viewModel.next(currentUserStorage: currentUserStorage)
        
        #expect(viewModel.currentIndex == AppOnboardingView.Screen.photoFiltered.rawValue)
        
        await viewModel.next(currentUserStorage: currentUserStorage)
        #expect(viewModel.sceneStartState == .home)
        #expect(currentUserStorage.userSpy.hasSeenOnboarding == true)
    }
    
    @Test("Filter should throw error")
    func filterErrorNoFace() async throws {
        let viewModel = AppOnboardingViewModel(
            analytics: AppOnboardingAnalytics(),
            filterService: FilterServiceErrorSpy(),
            storage: UserPhotoStorageSpy()
        )
        
        #expect(viewModel.error == nil)
        
        let isSuccess = await viewModel.filter(photo: Data())
        #expect(isSuccess == false)
        let error = try #require(viewModel.error)
        #expect(error.id == 2)
        
    }
}
