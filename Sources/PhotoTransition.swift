//
//  PhotoTransition.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/23.
//
//

import UIKit
import SpriteKit

public struct PhotoTransitionContext {
    let action: SKAction
}

public protocol PhotoTransition {
    var appearDuration: TimeInterval { get }
    var disappearDuration: TimeInterval { get }
    
    func value(for key: String) -> Any?
    func set(value: Any, for key: String)
    
    func appearTransition(photo: Photo, in: SceneContext) -> PhotoTransitionContext
    func disappearTransition(photo: Photo, in: SceneContext) -> PhotoTransitionContext
    
    func appearProgress(context: PhotoTransitionContext)
    func disappearProgress(context: PhotoTransitionContext)
}

public extension PhotoTransition {
    public static var idenfifer: String {
        return String(describing: self)
    }
    
    public func appearProgress(_: PhotoTransitionContext) {
    }
    
    public func disappearProgress(_: PhotoTransitionContext) {
    }
}
