//
//  AppOnboardingView.swift
//  New Apps Test
//
//  Created by Haïthem Ben Harzallah on 27/12/2024.
//

import DesignSystem
import PhotoFilterService
import SwiftUI

struct AppOnboardingView: View {
    
    enum Screen: Int, CaseIterable {
        case resume = 0, userInfo, photoPick, photoFiltered
        
        static var maxIndex: Int { Screen.allCases.map { $0.rawValue}.max() ?? 2 }
    }
    
    @Environment(\.currentUserStorage) private var currentUserStorage
    
    @StateObject var viewModel = AppOnboardingViewModel(
        analytics: AppOnboardingAnalytics(),
        filterService: AppPhotoFilterService(),
        storage: AppUserPhotoStorage()
    )
    @Binding var userAction: AppSceneStartState
    
    init(userAction: Binding<AppSceneStartState>) {
        // This is probably more convenient to use @Environment to inject photo filter service. This is just an exemple injection by init.
        
        let filterService: PhotoFilterService = if ProcessInfo().arguments.contains("uitest_run") {
            FilterServiceSpy()
        } else {
            AppPhotoFilterService()
        }
        
        _viewModel = StateObject(wrappedValue: AppOnboardingViewModel(
            analytics: AppOnboardingAnalytics(),
            filterService: filterService,
            storage: AppUserPhotoStorage()
        ))
        self._userAction = userAction
    }
    
    var maxIndex: Int = Screen.maxIndex
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentIndex) {
                
                AppOnboardingResumeView(analytics: viewModel.analytics)
                    .tag(Screen.resume.rawValue)

                AppOnboardingUserInfoView(email: $viewModel.email, emailValidator: EmailValidator())
                    .tag(Screen.userInfo.rawValue)
                
                AppOnboardingPhotoPickView(photoSelected: $viewModel.photo)
                    .tag(Screen.photoPick.rawValue)
                
                if let uiimage = viewModel.photoFiltered {
                    AppOnboardingPhotoFilteredView(photo: uiimage)
                        .tag(Screen.photoFiltered.rawValue)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .id(1)
            
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 8) {
                    
                    if viewModel.showPreviousButton {
                        Button {
                            viewModel.previous()
                        } label: {
                            Text("Previous")
                        }
                        .buttonStyle(SecondaryButtonStyle.default)
                        .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            maxHeight: 44
                        )
                        .padding([.leading, .trailing], 16)
                        .padding(.bottom, 32)
                        .accessibilityIdentifier("previous_button")
                    }
                    
                    Button {
                        Task {
                            await viewModel.next(currentUserStorage: currentUserStorage)
                        }
                    } label: {
                        Text(highlightButtonText())
                    }
                    .buttonStyle(TertiaryExtendableButtonStyle.default)
                    .disabled(shouldDisableContinueButton)
                    .opacity(shouldDisableContinueButton ? 0.5 : 1)
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 32)
                    .accessibilityIdentifier("next_button")
                }
            }
            
            Spacer()
        }
        .overlay(content: {
            if viewModel.isShowingLoading {
                ZStack {
                    Color.systemBackground
                    
                    FullPageLoadingView(text: "Loading")
                }
            } else if let error = viewModel.error {
                ZStack {
                    Color.systemBackground
                    
                    PageErrorButtonsView(
                        error: error,
                        buttons: [
                            ButtonPageErrorAction(
                                id: 1,
                                titleButton: String(localized: "Retry"),
                                action: {
                                    self.viewModel.error = nil
                                }
                            )
                        ],
                        foregroundStyle: .init(all: Color.systemBackground),
                        backgroundColor: Color.primary
                    )
                }
        }
        })
        .onChange(of: viewModel.sceneStartState, perform: { newValue in
            userAction = newValue
        })
        .edgesIgnoringSafeArea(.all)
        .animation(.easeOut, value: viewModel.currentIndex)
    }
    
    private var shouldDisableContinueButton: Bool {
        viewModel.currentIndex == Screen.photoPick.rawValue && !viewModel.photo.hasPhoto
    }
    
    private func highlightButtonText() -> String {
        switch viewModel.currentIndex {
        case Screen.resume.rawValue:
            return String(localized: "Begin")
        default:
            return String(localized: "Continue")
        }
    }
}

#Preview("English") {
    AppOnboardingView(userAction: .constant(.onboarding))
}

#Preview("French Dark") {
    AppOnboardingView(userAction: .constant(.onboarding))
        .preferredColorScheme(.dark)
        .environment(\.locale, .init(identifier: "fr"))
}
