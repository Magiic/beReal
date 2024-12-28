import SwiftUI

public extension View {
    
    func applyForegroundStyle<S: ShapeStyle>(_ platformColor: AppPlatformShapeStyle<S>) -> some View {
        self
        #if os(visionOS)
        .foregroundStyle(platformColor.visionOS)
        #elseif os(iOS)
        .foregroundStyle(platformColor.iOS)
        #elseif os(macOS)
        .foregroundStyle(platformColor.macOS)
        #elseif os(tvOS)
        .foregroundStyle(platformColor.tvOS)
        #elseif os(watchOS)
        .foregroundStyle(platformColor.watchOS)
        #else
        .foregroundStyle(platformColor.iOS)
        #endif
    }
    
    func apply2ForegroundStyle<S: ShapeStyle, V: ShapeStyle>(_ platformColor: AppPlatformShapeStyle<S>, secondStyle: AppPlatformShapeStyle<V>) -> some View {
        self
        #if os(visionOS)
        .foregroundStyle(platformColor.visionOS, secondStyle.visionOS)
        #elseif os(iOS)
        .foregroundStyle(platformColor.iOS, secondStyle.iOS)
        #elseif os(macOS)
        .foregroundStyle(platformColor.macOS, secondStyle.macOS)
        #elseif os(tvOS)
        .foregroundStyle(platformColor.tvOS, secondStyle.tvOS)
        #elseif os(watchOS)
        .foregroundStyle(platformColor.watchOS, secondStyle.watchOS)
        #else
        .foregroundStyle(platformColor.iOS, secondStyle.iOS)
        #endif
    }
    
    func applyBackgroundStyle<S: ShapeStyle, I: InsettableShape>(_ platformStyle: AppPlatformShapeStyle<S>, in shape: I) -> some View {
        self
        #if os(visionOS)
        .background(platformStyle.visionOS, in: shape)
        #elseif os(iOS)
        .background(platformStyle.iOS, in: shape)
        #elseif os(macOS)
        .background(platformStyle.macOS, in: shape)
        #elseif os(tvOS)
        .background(platformStyle.tvOS, in: shape)
        #elseif os(watchOS)
        .background(platformStyle.watchOS, in: shape)
        #else
        .background(platformStyle.iOS, in: shape)
        #endif
            
    }
}
