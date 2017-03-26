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
    
    open func duration(for action: PresenterAction) -> CGFloat {
        return 0		// FIXME
    }
    
    open func load(to scene: SceneContext, completion handler: @escaping (Result<PhotoNodeContext, PresenterLoadError>) -> Void) -> Any? {
        let options = SystemPhotoContentLoadOptions()	// FIXME
        return self.photoContentLoader.load(with: options) { (result) in
            switch result {
            case .success(let content):
                // FIXME
                let node = SKSpriteNode()
                handler(.success(PhotoNodeContext(node: node)))
            case .failure(let error):
                handler(.failure(.contentLoadError(error)))
            }
        }
    }
    
    open func cancel(identifier: Any) {
        self.photoContentLoader.cancel(requestID: identifier)
    }
    
    open func perform(action: PresenterAction, node: PhotoNodeContext, in: SceneContext) {
        // FIXME
    }
    
    open func unload(node: PhotoNodeContext, from scene: SceneContext) {
        // FIXME
    }
    
    // MARK: - Direction
    
    public struct Direction {
        let transition: PhotoTransition
        let filter: PhotoFilter
    }
}
