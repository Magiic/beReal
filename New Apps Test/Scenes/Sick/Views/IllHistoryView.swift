import AssetSelectionPicker
import DesignSystem
import PhotoFilterService
import SwiftUI

struct IllHistoryView: View {
    
    let filterService: PhotoFilterService
    
    private enum Destination: Hashable {
        case illCheck
    }
        
    @State private var collection: UserPhotoCollection = UserPhotoCollection(photos: [])
    @State private var photoSelected: PhotoPickerState = .empty
    @State private var path = [Destination]()
    @Environment(\.userPhotoStorage) private var userPhotoStorage
    
    var body: some View {
        NavigationStack(path: $path) {
            GridSelectionView(
                items: collection.sortedPhotos,
                columns: [
                    GridItem(.adaptive(minimum: 150, maximum: .infinity), spacing: 16)
                ],
                spacing: 16
            ) {
                EmptyContentView(
                    content: EmptyContentViewData(
                        text: "No content",
                        description: "No content",
                        iconName: "photo.on.rectangle.angled.fill",
                        action: EmptyContentViewData.Action(
                            title: "Add",
                            iconName: "plus",
                            tap: {
                                path.append(.illCheck)
                            })
                    )
                )
                .ignoresSafeArea(.all, edges: .bottom)
            } content: { item in
                IllHistoryItemView(userPhoto: item)
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        path.append(.illCheck)
                    }
                    .foregroundStyle(Color.primaryApp)
                }
            }
            .navigationDestination(for: Destination.self) { value in
                switch value {
                case .illCheck:
                    IllCheckView(filterService: filterService) {
                        Task {
                            await fetch()
                        }
                    }
                }
            }
        }
        .task {
            await fetch()
        }
    }
    
    private func fetch() async {
        do {
            collection = try await userPhotoStorage.fetch()
        } catch {
            AppLogger.illHistory.error("Failed fetch user photos history \(error)")
        }
    }
}

#Preview("History") {
    IllHistoryView(filterService: AppPhotoFilterService())
}
