//
//  PhotoAlbumStage.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit

open class PhotoAlbumStage: Stage {
    public let photoAlbum: PhotoAlbum
    public let direction: Direction
    
    public init(photoAlbum: PhotoAlbum, direction: Direction) {
        self.photoAlbum = photoAlbum
        self.direction = direction
    }
    
    // MARK: - Stage
    
    @discardableResult
    open func load(
        to scene: SceneContext,
        completion handler: @escaping (Result<StageNodeContext, StageLoadError>) -> Void
    ) -> Any? {

        switch self.direction.background {
        case .color(let color):
            scene.body.backgroundColor = color
            handler(.success(StageNodeContext(bodyScene: scene.body)))
            return nil
        // TODO: 背景テクスチャの読み込みなど
        }
    }
    
    open func cancel(identifier: Any) {
        // FIXME
    }
    
    open func present(context: StageNodeContext) {
        // FIXME
    }
    
    open func unload(context: StageNodeContext) {
        // FIXME
    }
    
    // MARK: - Direction
    
    public struct Direction {
        public enum Background {
            case color(UIColor)
        }
        
        public let background: Background
        
        public init(
            background: Background
        ) {
            self.background = background
        }
    }
}
