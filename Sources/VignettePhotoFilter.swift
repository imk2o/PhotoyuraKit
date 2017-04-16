//
//  VignettePhotoFilter.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/04/16.
//
//

import UIKit
import SpriteKit

public struct VignettePhotoFilter: PhotoFilter {
    public let intensity: CGFloat
    
    public init(intensity: CGFloat = 2.5) {
        self.intensity = intensity
    }
    
    // MARK: - PhotoFilter
    
    public func filter(photo: Photo, in: SceneContext) -> PhotoFilterContext {
        let filter = CIFilter(
            name: "CIVignette",
            withInputParameters: [
                "inputIntensity": self.intensity
            ]
        )!

        return PhotoFilterContext(filter: filter)
    }
}
