//
//  PhotoAlbumScript.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit

open class PhotoAlbumScript: Script {
    public let photoAlbum: PhotoAlbum
    public let configuration: Configuration
    
    public init(photoAlbum: PhotoAlbum, configuration: Configuration) {
        self.photoAlbum = photoAlbum
        self.configuration = configuration
    }

    // MARK: - Script
    
    open func stage() -> Stage {
        return PhotoAlbumStage(
            photoAlbum: self.photoAlbum,
            configuration: self.configuration.stageConfiguration
        )
    }
    
    open func nextPresenter() -> Presenter? {
        return nil		// FIXME
    }
    
    open func previousPresenter() -> Presenter? {
        return nil		// FIXME
    }
    
    // MARK: - Configuration
    
    public struct Configuration {
        public let name: String
        
        public let presenterDirection: PhotoPresenter.Direction
        public let stageConfiguration: PhotoAlbumStage.Configuration	// FIXME: Direction
    }
}
