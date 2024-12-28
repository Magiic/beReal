//
//  AppOnboardingViewModel.swift
//  New Apps Test
//
//  Created by Haïthem Ben Harzallah on 27/12/2024.
//

import AssetSelectionPicker
import AppStorage
import DesignSystem
import PhotoFilterService
import SwiftUI

@MainActor
final class AppOnboardingViewModel: ObservableObject {
    
    @Published var sceneStartState: AppSceneStartState = .onboarding
    @Published var email: String = ""
    @Published var photo: PhotoPickerState = .empty
    @Published var photoFiltered: UIImage?
    @Published var error: ErrorData?
    @Published var currentIndex: Int = 0
    @Published var isShowingLoading = false
    var maxIndex: Int = AppOnboardingView.Screen.maxIndex
    
    let analytics: OnboardingAnalytics
    let filterService: PhotoFilterService
    let storage: UserPhotoStorage
    
    init(
        analytics: OnboardingAnalytics,
        filterService: PhotoFilterService,
        storage: UserPhotoStorage
    ) {
        self.analytics = analytics
        self.filterService = filterService
        self.storage = storage
    }
    
    func previous() {
        currentIndex -= 1
    }
    
    func next(currentUserStorage: CurrentUserStorage) async {
        if currentIndex < maxIndex {
            if currentIndex == AppOnboardingView.Screen.photoPick.rawValue {
                if case let .success(photoData) = photo {
                    let isSuccess = await filter(photo: photoData)
                    if isSuccess {
                        currentIndex += 1
                    }
                }
            } else {
                currentIndex += 1
            }
            
        } else if currentIndex == maxIndex {
            await didFinishOnboarding(currentUserStorage: currentUserStorage)
        }
    }
    
    func didFinishOnboarding(currentUserStorage: CurrentUserStorage) async {
        await updateSeenOboarding(true, userStorage: currentUserStorage)
        
        sceneStartState = .home
    }
    
    var showPreviousButton: Bool {
        1...maxIndex ~= currentIndex
    }
    
    func storePhotoFiltered(photo: UIImage) async throws {
        try await storage.storePhotoFiltered(photo: photo)
    }
    
    func updateSeenOboarding(_ value: Bool, userStorage: CurrentUserStorage) async {
        do {
            var currentUser = try userStorage.get()
            currentUser.hasSeenOnboarding = true
            try userStorage.store(user: currentUser)
        } catch {
            AppLogger.onboarding.error("Cannot store new current user after seen onboarding \(error)")
        }
    }
    
    func filter(photo: Data) async -> Bool {
        defer {
            isShowingLoading = false
        }
        
        isShowingLoading = true
        
        do {
            let resultPhoto = try await filterService.applyDistortion(toImageData: photo, effects: .noiseBigger)
            photoFiltered = resultPhoto
            if let resultPhoto {
                try await storePhotoFiltered(photo: resultPhoto)
            }
            return true
        } catch let err as PhotoFilterServiceError {
            AppLogger.onboarding.error("Filter photo failed \(err)")
            
            self.error = switch err {
            case .noFaces:
                ErrorData(error: FilterPhotoViewError.noFaces)
            case .simulator:
                ErrorData(error: FilterPhotoViewError.simulator)
            default:
                ErrorData(error: AppViewGenericError.generic)
            }
            
            return false
        } catch {
            AppLogger.onboarding.error("Filter photo failed \(error)")
            self.error = ErrorData(error: AppViewGenericError.generic)
            return false
        }
    }
}

extension PhotoPickerState {
    
    var hasPhoto: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
}
