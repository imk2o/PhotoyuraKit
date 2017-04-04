//
//  Scene.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit
import SpriteKit

public class Scene: SKScene {
    enum Node: String {
        case root
        case photoLayer
        
        var identifier: String {
            return self.rawValue
        }
        
        func instantiate() -> SKNode {
            let node = SKNode()
            node.name = self.identifier
            
            return node
        }
        
        func child(for scene: Scene) -> SKNode? {
            return scene.childNode(withName: self.identifier)
        }
    }

    public override init(size: CGSize) {
        super.init(size: size)
        self.setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func node(_ node: Node) -> SKNode! {
        return node.child(for: self)
    }
    
    private func setup() {
        let rootNode = Node.root.instantiate()
        // 中心を (0, 0) に
        rootNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(rootNode)
        
        let photoLayerNode = Node.photoLayer.instantiate()
        rootNode.addChild(photoLayerNode)
    }
}
