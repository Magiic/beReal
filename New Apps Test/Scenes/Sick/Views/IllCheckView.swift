import AssetSelectionPicker
import DesignSystem
import PhotoFilterService
import SwiftUI

struct IllCheckView: View {
    
    private enum ViewState {
        case photoSelection
        case filtering
        case failure(ErrorData)
        case result(UIImage)
    }
    
    @State private var photoSelected: PhotoPickerState = .empty
    let filterService: PhotoFilterService
    let newPhoto: () -> Void
    
    @Environment(\.userPhotoStorage) private var userPhotoStorage
    @Environment(\.currentUserStorage) private var currentUserStorage
    @Environment(\.photoFilterManager) private var photoFilterManager
    
    @State private var viewState: ViewState = .photoSelection
    
    var body: some View {
        VStack {
            switch viewState {
            case .photoSelection:
                IllPickerAssetView(photoSelected: $photoSelected)
            case .filtering:
                ProgressView()
            case .failure(let errorData):
                PageErrorButtonsView(
                    error: errorData,
                    buttons: [
                        ButtonPageErrorAction(
                            id: 1,
                            titleButton: String(localized: "Retry"),
                            action: {
                                viewState = .photoSelection
                            }
                        )
                    ],
                    foregroundStyle: .init(all: Color.primaryInvert),
                    backgroundColor: Color.primaryApp
                )
                PageErrorView(error: errorData)
            case .result(let photo):
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        
                        IllResultView(photo: photo)
                        
                        IllSharingView(
                            text: String(localized: "Don't panic. First, let your friends and family know about your symptoms. Tell them they can use the app to check their health."),
                            photo: photo
                        )
                        
                        MedicinesInformativeView(isShowingPaywallButton: true)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .onChange(of: photoSelected) { newValue in
            if case let .success(photoData) = newValue {
                Task {
                    do {
                        let currentUser = try currentUserStorage.get()
                        let filters = photoFilterManager.filters(currentUser: currentUser)
                        await filter(photo: photoData, effects: filters)
                    } catch {
                        AppLogger.illHistory.error("Cannot get current user")
                    }
                }
            }
        }
    }
    
    func filter(photo: Data, effects: PhotoFilterEffectOption) async {
        
        viewState = .filtering
        
        do {
            let resultPhoto = try await filterService.applyDistortion(
                toImageData: photo,
                effects: effects
            )
            if let resultPhoto {
                try await userPhotoStorage.storePhotoFiltered(photo: resultPhoto)
                viewState = .result(resultPhoto)
                newPhoto()
            } else {
                viewState = .failure(ErrorData(error: AppViewGenericError.generic))
            }
            
        } catch let err as PhotoFilterServiceError {
            AppLogger.onboarding.error("Filter photo failed \(err)")
            
            switch err {
            case .noFaces:
                viewState = .failure(ErrorData(error: FilterPhotoViewError.noFaces))
            case .simulator:
                viewState = .failure(ErrorData(error: FilterPhotoViewError.simulator))
            default:
                viewState = .failure(ErrorData(error: AppViewGenericError.generic))
            }
        } catch {
            AppLogger.onboarding.error("Filter photo failed \(error)")
            viewState = .failure(ErrorData(error: AppViewGenericError.generic))
        }
    }
}

@available(iOS 18, *)
#Preview {
    @Previewable @State var photo: PhotoPickerState = .empty
    IllCheckView(filterService: AppPhotoFilterService()) {}
}
