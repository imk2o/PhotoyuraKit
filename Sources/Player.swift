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
    fileprivate var currentPresenter: Presenter?
    
    public var scene: Scene? {
        return self.view?.scene as? Scene
    }
    
    public init(view: SKView, script: Script) {
        self.view = view
        self.script = script
        
        self.setupScene()
    }

    @discardableResult
    public func perform(action: Action) -> Bool {
        switch action {
        case .play:
            return self.play()
        default:
            return false		// FIXME
        }
    }
    
    open static func createScene(size: CGSize) -> Scene {
        return Scene(size: size)
    }
    
    // MARK: - Presentation Queue
    struct Presentation {
        let presenter: Presenter
        let photoNodeContext: PhotoNodeContext
    }
    fileprivate var presentationQueue: [Presentation] = []
}

private extension Player {
    var sceneContext: SceneContext {
        guard let scene = self.scene else {
            fatalError()
        }
        
        return SceneContext(scene: scene)
    }
    
    func setupScene() {
        guard let view = self.view else {
            fatalError()
        }
        
        let scene = type(of: self).createScene(size: view.bounds.size)
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
    }
    
    func play() -> Bool {
        return self.next()
    }
    
    func next() -> Bool {
        self.unloadToDequeue()
        
        guard let nextPresenter = self.script.presenter(forNext: true) else {
            // FIXME: end
            return false
        }

        self.loadToEnqueue(presenter: nextPresenter)
        
//        self.currentPresenter = nextPresenter
        
        return true
    }
    
    func loadToEnqueue(presenter: Presenter) {
        presenter.load(to: self.sceneContext) { [weak self] (result) in
            switch result {
            case .success(let photoNodeContext):
                let presentation = Presentation(
                    presenter: presenter,
                    photoNodeContext: photoNodeContext
                )
                self?.addPresentation(presentation)
            case .failure(let error):
                print(error)		// FIXME
                break
            }
        }
    }

    @discardableResult
    func unloadToDequeue() -> Presenter? {
        guard let presentation = self.presentationQueue.first else {
            return nil
        }
        
        self.endPresent(presentation)
        
        let _ = self.presentationQueue.dropFirst()
        
        return presentation.presenter
    }
    
    func addPresentation(_ presentation: Presentation) {
        // FIXME: 自動でキューをまわすようになったら戻す
        let performNow = true//self.presentationQueue.isEmpty
        self.presentationQueue.append(presentation)
        
        if performNow {
            self.startPresent(presentation)
        }
    }
    
    func startPresent(_ presentation: Presentation) {
        presentation.presenter.perform(
            action: .appear,
            node: presentation.photoNodeContext,
            in: self.sceneContext
        ) { [weak self] in
            // play状態へ
            self?.playPresent(presentation)
        }
    }

    func playPresent(_ presentation: Presentation) {
        presentation.presenter.perform(
            action: .play,
            node: presentation.photoNodeContext,
            in: self.sceneContext
        ) { [weak self] in
            // キューからpopし、disappear状態へ
            //self?.unloadToDequeue()
            self?.next()
        }
    }
    
    func endPresent(_ presentation: Presentation) {
        presentation.presenter.perform(
            action: .disappear,
            node: presentation.photoNodeContext,
            in: self.sceneContext
        ) { [weak self] in
            self?.unloadPresent(presentation)
        }
    }
    
    func unloadPresent(_ presentation: Presentation) {
        presentation.presenter.unload(
            node: presentation.photoNodeContext,
            from: self.sceneContext
        )
    }
}
