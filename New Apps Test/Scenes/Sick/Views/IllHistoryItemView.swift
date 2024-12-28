import SwiftUI

struct IllHistoryItemView: View {
    let userPhoto: UserPhoto
    
    var body: some View {
        VStack(spacing: 8) {
            if let uiimage = UIImage(data: userPhoto.photo) {
                IllPhotoView(photo: uiimage, size: CGSize(width: 100, height: 100))
                    .padding(20)
                    .background(Color.systemGray6, in: .circle)
                
                Text(userPhoto.date, style: .date)
                    .footnoteTextStyle(color: .init(all: .secondary))
            }
        }
    }
}

#Preview {
    IllHistoryItemView(userPhoto: UserPhoto.fake)
}
