import CoreImage.CIFilterBuiltins
import UIKit
import Vision

public actor AppPhotoFilterService: PhotoFilterService {
    
    public init() {}
    
    public func applyDistortion(toImageData data: Data, effects: PhotoFilterEffectOption = .noiseBigger) async throws -> UIImage? {
        guard let uiimage = UIImage(data: data) else {
            throw PhotoFilterServiceError.invalidImage
        }
        
        return try await applyDistortion(to: uiimage, effects: effects)
    }
    
    public func applyDistortion(to image: UIImage, effects: PhotoFilterEffectOption) async throws -> UIImage {
        #if targetEnvironment(simulator)
        throw PhotoFilterServiceError.simulator
        #endif
        
        guard let ciImage = CIImage(image: image) else {
            throw PhotoFilterServiceError.invalidImage
        }
        
        let orientedImage = ciImage.oriented(forExifOrientation: Int32(image.imageOrientation.rawValue))
        let mirroredImage = mirroringImage(orientedImage, orientation: image.imageOrientation)
        
        let handler = VNImageRequestHandler(ciImage: mirroredImage, options: [:])
        let value = try await withCheckedThrowingContinuation { continuation in
            let faceLandmarkRequest = VNDetectFaceLandmarksRequest { request, error in
                
                if let observations = request.results as? [VNFaceObservation], !observations.isEmpty {
                    var finalImage = mirroredImage
                    for face in observations {
                        if let distortedImage = AppPhotoFilterService.applyBumpDistortion(to: finalImage, face: face, effects: effects) {
                            finalImage = distortedImage
                        }
                    }
                    
                    let context = CIContext()
                    if let cgImage = context.createCGImage(finalImage, from: finalImage.extent) {
                        continuation.resume(returning: UIImage(cgImage: cgImage))
                    } else {
                        continuation.resume(throwing: PhotoFilterServiceError.filter)
                    }
                } else {
                    continuation.resume(throwing: PhotoFilterServiceError.noFaces)
                }
            }
            
            do {
                try handler.perform([faceLandmarkRequest])
            } catch {
                continuation.resume(throwing: PhotoFilterServiceError.perform(error))
            }
        }
        
        return value
    }
    
    static func applyBumpDistortion(
        to ciImage: CIImage,
        face: VNFaceObservation,
        effects: PhotoFilterEffectOption
    ) -> CIImage? {
        guard let landmarks = face.landmarks else { return ciImage }
        
        var distortedImage = ciImage
        
        let imageSize = ciImage.extent.size
        let faceBoundingBox = face.boundingBox
        let faceRect = VNImageRectForNormalizedRect(faceBoundingBox, Int(imageSize.width), Int(imageSize.height))
        
        if effects.contains(.noiseBigger), let nose = landmarks.nose {
            distortedImage = applyBumpEffect(to: distortedImage, points: nose.normalizedPoints, faceRect: faceRect, size: imageSize)
        }
        
        if effects.contains(.skinColor), let greenSkinImage = applyGreenSkinEffect(to: distortedImage, face: face) {
            distortedImage = greenSkinImage
        }
        
        if effects.contains(.skinBlackDots), let nose = landmarks.nose {
            distortedImage = addBlackDots(to: distortedImage, points: nose.normalizedPoints, faceRect: faceRect)
        }
        
        return distortedImage
    }
    
    private static func applyBumpEffect(to ciImage: CIImage, points: [CGPoint], faceRect: CGRect, size: CGSize) -> CIImage {
        guard let filter = CIFilter(name: "CIBumpDistortion") else { return ciImage }
        
        // Average the points to find the center eye or nose for example
        let center = points.reduce(CGPoint.zero) { $0 + $1 } / CGFloat(points.count)
        
        let point = CGPoint(
            x: center.x * faceRect.width + faceRect.origin.x,
            y: (1 - center.y) * faceRect.height + faceRect.origin.y
        )
        
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(CIVector(x: point.x, y: point.y), forKey: kCIInputCenterKey)
        filter.setValue(140, forKey: kCIInputRadiusKey)
        filter.setValue(0.55, forKey: kCIInputScaleKey)
        
        return filter.outputImage ?? ciImage
    }
    
    static func applyGreenSkinEffect(to ciImage: CIImage, face: VNFaceObservation) -> CIImage? {
        let faceBoundingBox = face.boundingBox
        
        let imageSize = ciImage.extent.size
        let faceRect = VNImageRectForNormalizedRect(faceBoundingBox, Int(imageSize.width), Int(imageSize.height))
        
        let croppedFace = ciImage.cropped(to: faceRect)
        
        guard let filter = CIFilter(name: "CIColorMatrix") else { return ciImage }
        filter.setValue(croppedFace, forKey: kCIInputImageKey)
        
        filter.setValue(CIVector(x: 0, y: 1, z: 0, w: 0), forKey: "inputRVector")
        filter.setValue(CIVector(x: 0, y: 1.2, z: 0, w: 0), forKey: "inputGVector")
        filter.setValue(CIVector(x: 0, y: 0, z: 0.5, w: 0), forKey: "inputBVector")
        filter.setValue(CIVector(x: 0, y: 0, z: 0, w: 1), forKey: "inputAVector")
        
        guard let greenFace = filter.outputImage else { return ciImage }
        let compositeFilter = CIFilter(name: "CISourceOverCompositing")!
        compositeFilter.setValue(greenFace, forKey: kCIInputImageKey)
        compositeFilter.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        return compositeFilter.outputImage
    }
    
    private static func addBlackDots(to ciImage: CIImage, points: [CGPoint], faceRect: CGRect) -> CIImage {
        var compositedImage = ciImage
        
        for point in points {
            let pointInImage = CGPoint(
                x: point.x * faceRect.width + faceRect.origin.x,
                y: (1 - point.y) * faceRect.height + faceRect.origin.y
            )
            
            if let blackDot = generateBlackDot(at: pointInImage, radius: 8, size: ciImage.extent.size) {
                let compositeFilter = CIFilter(name: "CISourceOverCompositing")!
                compositeFilter.setValue(blackDot, forKey: kCIInputImageKey)
                compositeFilter.setValue(compositedImage, forKey: kCIInputBackgroundImageKey)
                compositedImage = compositeFilter.outputImage!
            }
        }
        
        return compositedImage
    }
    
    private static func generateBlackDot(at point: CGPoint, radius: CGFloat, size: CGSize) -> CIImage? {
        let gradientFilter = CIFilter(name: "CIRadialGradient")!
        gradientFilter.setValue(CIVector(x: point.x, y: point.y), forKey: kCIInputCenterKey)
        gradientFilter.setValue(radius, forKey: "inputRadius0")
        gradientFilter.setValue(radius + 1, forKey: "inputRadius1")
        gradientFilter.setValue(CIColor.black, forKey: "inputColor0")
        gradientFilter.setValue(CIColor.clear, forKey: "inputColor1")
        
        // Crop to the size of the original image to avoid overflow
        return gradientFilter.outputImage?.cropped(to: CGRect(origin: .zero, size: size))
    }
    
    private func mirroringImage(_ image: CIImage, orientation: UIImage.Orientation) -> CIImage {
        let isMirrored = (orientation == .leftMirrored || orientation == .rightMirrored)
        
        let mirroredImage = if isMirrored {
            image.transformed(by: CGAffineTransform(scaleX: -1, y: 1)
                .translatedBy(x: -image.extent.width, y: 0))
        } else {
            image
        }
        
        return mirroredImage
    }
}

// Helper to add two CGPoint values
func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

// Helper to divide CGPoint by scalar
func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: point.x / scalar, y: point.y / scalar)
}
