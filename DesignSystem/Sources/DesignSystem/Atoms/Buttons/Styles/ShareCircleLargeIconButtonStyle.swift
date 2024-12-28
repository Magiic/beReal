//
//  ShareCircleLargeIconButtonStyle.swift
//  
//
//  Created by Haïthem Ben Harzallah on 13/06/2024.
//

import SwiftUI

public struct ShareCircleLargeIconButtonStyle<T: ShapeStyle>: ButtonStyle {
    
    public let tintStyle: AppPlatformShapeStyle<T>
    
    public init(tintStyle: AppPlatformShapeStyle<T>) {
        self.tintStyle = tintStyle
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        CircleLargeIconView(
            systemName: "doc.on.clipboard.fill",
            tintStyle: tintStyle
        )
        .contentShape(.interaction, .circle)
        .contentShape(.hoverEffect, CircleSizeShape(size: .init(width: 50, height: 50)))
        .hoverEffect()
    }
}

#Preview {
    Button("") {}
        .buttonStyle(ShareCircleLargeIconButtonStyle(tintStyle: .init(all: Color.systemGray)))
}
