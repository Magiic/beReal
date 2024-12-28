import SwiftUI

public struct GridSelectionView<EmptyContent: View, Content: View, Item: Hashable & Identifiable>: View {
    
    private let items: [Item]
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)
    ]
    var spacing: Double = 3
    @ViewBuilder var emptyContent: () -> EmptyContent
    @ViewBuilder var content: (Item) -> Content
    
    public init(
        items: [Item],
        columns: [GridItem] = [
            GridItem(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)
        ],
        spacing: Double = 3,
        @ViewBuilder emptyContent: @escaping () -> EmptyContent,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.items = items
        self.columns = columns
        self.emptyContent = emptyContent
        self.content = content
        self.spacing = spacing
    }
    
    public var body: some View {
        VStack {
            if items.isEmpty {
                emptyContent()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(items) { item in
                            content(item)
                        }
                    }
                }
            }
        }
    }
}
