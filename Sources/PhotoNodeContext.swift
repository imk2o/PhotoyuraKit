//
//  PhotoNodeContext.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/24.
//
//

import UIKit
import SpriteKit

public struct PhotoNodeContext {
    public let node: SKNode
    
    var scene: SceneContext {
        guard let scene = self.node.scene as? Scene else {
            fatalError("Node is not a child of the Scene.")
        }
        
        return SceneContext(scene: scene)
    }
}
