//
//  RootView.swift
//  New Apps Test
//
//  Created by Michel-Andre Chirita on 28/06/2024.
//

/*
 --------------------------------------------------
 -- Voodoo New Apps Tech Test
 -- BOOSTRAP FILE
 -- Feel free to modify or dismiss it as you like !
 --------------------------------------------------
 */

import PhotoFilterService
import SwiftUI

struct RootView: View {
    
    @Environment(\.currentUserStorage) private var currentUserStorage
    @Environment(\.photoFilterManager) private var photoFilterManager
    
    @State private var filterService: PhotoFilterService = AppPhotoFilterService()
    @State private var filterEffects: PhotoFilterEffectOption = .noiseBigger
    
    var body: some View {
        TabView {
            
            IllHistoryView(filterService: AppPhotoFilterService())
                .tabItem {
                    Image(systemName: "house")
                }
            
            PaywallView()
                .tabItem {
                    Image(systemName: "dollarsign")
                }
            /*
             // Not used
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }

            FriendsView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                }
             */
        }
        .task {
            do {
                let currentUser = try currentUserStorage.get()
                filterEffects = photoFilterManager.filters(currentUser: currentUser)
            } catch {
                AppLogger.illHistory.error("Cannot get current user")
            }
        }
    }
}

#Preview {
    RootView()
}
