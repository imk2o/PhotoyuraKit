//
//  Player.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit
import SpriteKit

open class Player {
    public enum Action {
        case play
        case pause
        case resume
        case next
        case previous
    }

    public enum State {
        case ready
        case prepareForPlay
        case playing
        case paused
    }
    
    fileprivate(set) public weak var view: SKView?
    public let script: Script

    public var scene: Scene? {
        return self.view?.scene as? Scene
    }
    
    public init(view: SKView, script: Script) {
        self.view = view
        self.script = script
        
        self.setupScene()
    }

    public func perform(action: Action) -> Bool {
        return false// FIXME
    }
    
    open static func createScene(size: CGSize) -> Scene {
        return Scene(size: size)
    }
}

private extension Player {
    func setupScene() {
        guard let view = self.view else {
            fatalError()
        }
        
        let scene = type(of: self).createScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
}
