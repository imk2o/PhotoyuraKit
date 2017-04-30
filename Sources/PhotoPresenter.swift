//
//  PhotoPresenter.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit
import SpriteKit

open class PhotoPresenter: Presenter {
    public let photo: Photo
    public let direction: Direction
    fileprivate let photoContentLoader: PhotoContentLoader
    
    public init(photo: Photo, direction: Direction) {
        self.photo = photo
        self.direction = direction
        
        self.photoContentLoader = self.photo.loader()
    }

    // MARK: - Presenter
    
    open func duration(for action: PresenterAction) -> TimeInterval {
        switch action {
        case .appear:
            return self.direction.transition.appearDuration
        case .play:
            return 5.0		// FIXME
        case .disappear:
            return self.direction.transition.disappearDuration
        }
    }
    
    open func load(to scene: SceneContext, completion handler: @escaping (Result<PhotoNodeContext, PresenterLoadError>) -> Void) -> Any? {
        let options = PhotoContentLoadOptions(
            systemRespondAs: .image,
            imagePreferredSize: scene.size,
            imageContentMode: .aspectFit
        )
        return self.photoContentLoader.load(with: options) { [weak self] (result) in
            switch result {
            case .success(let content):
                if let node = self?.createNode(with: content, in: scene) {
                    // SKNode -> SKScene
                    scene.node(.photoLayer).addChild(node)
                    handler(.success(PhotoNodeContext(node: node)))
                }
            case .failure(let error):
                handler(.failure(.contentLoadError(error)))
            }
        }
    }
    
    open func cancel(identifier: Any) {
        self.photoContentLoader.cancel(requestID: identifier)
    }
    
    open func perform(
        action: PresenterAction,
        node: PhotoNodeContext,
        in scene: SceneContext,
        completion handler: @escaping Presenter.PerformCompletionHandler
    ) {
        switch action {
        case .appear:
            self.appear(node: node, in: scene, completion: handler)
        case .play:
            self.play(node: node, in: scene, completion: handler)
        case .disappear:
            self.disappear(node: node, in: scene, completion: handler)
        }
    }
    
    open func unload(node context: PhotoNodeContext, from scene: SceneContext) {
        // SKScene -> SKNode
        context.node.removeFromParent()
    }
    
    // MARK: - Direction
    
    public struct Direction {
        public let transition: PhotoTransition
        public let filter: PhotoFilter
        
        public init(transition: PhotoTransition, filter: PhotoFilter) {
            self.transition = transition
            self.filter = filter
        }
    }
}

private extension PhotoPresenter {
    func createNode(with content: PhotoContent, in scene: SceneContext) -> SKNode {
        switch content {
        case .image(let image):
            let node = SKEffectNode()
            //        node.filter = frame.filter?.filter(context)
            
            //// AspectFit
            let texture = SKTexture(image: image)
            let textureSize = texture.size()
            let imageAspect = textureSize.width / textureSize.height
            let sceneAspect = scene.size.width / scene.size.height
            let scale = (imageAspect > sceneAspect) ?
                scene.size.width / textureSize.width :
                scene.size.height / textureSize.height
            
            let imageNode = SKSpriteNode(texture: texture)
            imageNode.setScale(scale)
            node.addChild(imageNode)
            
            return node
        case .livePhoto(let livePhoto):
            fatalError()		// FIXME
        case .video(let avAsset):
            fatalError()		// FIXME
        }
    }
    
    func appear(
        node context: PhotoNodeContext,
        in scene: SceneContext,
        completion handler: @escaping Presenter.PerformCompletionHandler
    ) {
        let transitionContext = self.direction.transition.appearTransition(photo: self.photo, in: scene)
        
        context.node.run(transitionContext.action) {
            handler()
        }
    }
    
    func play(
        node context: PhotoNodeContext,
        in scene: SceneContext,
        completion handler: @escaping Presenter.PerformCompletionHandler
    ) {
        let transitionContext = self.direction.transition.appearTransition(photo: self.photo, in: scene)
        
        let duration = self.duration(for: .play)
        let playAction = SKAction.customAction(withDuration: duration) { (_, elapased) in
        }
        
        context.node.run(playAction) {
            handler()
        }
    }
    
    func disappear(
        node context: PhotoNodeContext,
        in scene: SceneContext,
        completion handler: @escaping Presenter.PerformCompletionHandler
    ) {
        let transitionContext = self.direction.transition.disappearTransition(photo: self.photo, in: scene)
        
        context.node.run(transitionContext.action) {
            handler()
        }
    }
}
