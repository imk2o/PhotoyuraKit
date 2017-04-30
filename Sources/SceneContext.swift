//
//  SceneContext.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/24.
//
//

import UIKit
import SpriteKit

public struct SceneContext {
    let body: Scene
    
    public var size: CGSize {
        return self.body.size
    }
    
    func node(_ node: Scene.Node) -> SKNode {
        return self.body.node(node)
    }
}
