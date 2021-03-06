//
//  PhotoFilter.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/23.
//
//

import UIKit
import SpriteKit

public struct PhotoFilterContext {
    public let filter: CIFilter
}

public protocol PhotoFilter {
    static var identifier: String { get }
    
    func filter(photo: Photo, in: SceneContext) -> PhotoFilterContext
    func progress(context: PhotoFilterContext)
}

public extension PhotoFilter {
    public static var identifier: String {
        return String(describing: self)
    }
    
    public func progress(context _: PhotoFilterContext) {
    }
}
