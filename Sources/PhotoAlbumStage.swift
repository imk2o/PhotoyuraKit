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
    
    open func load(to: Scene, completion handler: @escaping (Result<Void, StageLoadError>) -> Void) -> Any? {

        // FIXME
        
        return nil
    }
    
    open func cancel(identifier: Any) {
        // FIXME
    }
    
    open func present(in: Scene, time: Time) {
        // FIXME
    }
    
    open func unload(from: Scene) {
        // FIXME
    }
    
    // MARK: - Direction
    
    public struct Direction {
        public init() {
        }
    }
}
