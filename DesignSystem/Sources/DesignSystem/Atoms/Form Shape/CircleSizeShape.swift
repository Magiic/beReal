import SwiftUI

public struct CircleSizeShape: Shape {
    
    public let size: CGSize
    
    public init(size: CGSize) {
        self.size = size
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: size.width / 2, startAngle: .zero, endAngle: .degrees(360), clockwise: false)
        
        return path
    }
}

#Preview {
    CircleSizeShape(size: .init(width: 120, height: 120))
        .foregroundStyle(.green)
}
