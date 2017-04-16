//
//  DissolvePhotoTransition.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/04/16.
//
//

import UIKit
import SpriteKit

public struct DissolvePhotoTransition: PhotoTransition {
    public let duration: TimeInterval
    
    public init(duration: TimeInterval = 0.5) {
        self.duration = duration
    }
    
    // MARK: - PhotoTransition
    
    public var appearDuration: TimeInterval {
        return self.duration
    }
    
    public var disappearDuration: TimeInterval {
        return self.duration
    }
    
    public func appearTransition(photo: Photo, in: SceneContext) -> PhotoTransitionContext {
        let initializeAction = SKAction.fadeAlpha(to: 0, duration: 0)
        let fadeInAction = SKAction.fadeIn(withDuration: self.appearDuration)
        let action = SKAction.sequence([initializeAction, fadeInAction])

        return PhotoTransitionContext(action: action)
    }
    
    public func disappearTransition(photo: Photo, in: SceneContext) -> PhotoTransitionContext {
        let action = SKAction.fadeAlpha(to: 0, duration: self.disappearDuration)

        return PhotoTransitionContext(action: action)
    }
}
