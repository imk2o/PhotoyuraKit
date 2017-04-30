//
//  StageNodeContext.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/04/30.
//
//

import UIKit
import SpriteKit

public struct StageNodeContext {
    public let bodyScene: SKScene
    
    var scene: SceneContext {
        guard let scene = self.bodyScene as? Scene else {
            fatalError("Node is not a child of the Scene.")
        }
        
        return SceneContext(body: scene)
    }
}
