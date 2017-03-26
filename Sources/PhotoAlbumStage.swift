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
    public let configuration: Configuration
    
    public init(photoAlbum: PhotoAlbum, configuration: Configuration) {
        self.photoAlbum = photoAlbum
        self.configuration = configuration
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
    
    // MARK: - Configuration
    
    public struct Configuration {
        
    }
}
