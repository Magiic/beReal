import SwiftUI

public struct FullPageLoadingView: View {
    
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(LocalizedStringKey(text))
                    .font(.title3)
                    .foregroundColor(.white)
                
                ProgressView()
                    .tint(.white)
            }
        }
    }
}

#Preview {
    FullPageLoadingView(text: "Loading")
}
