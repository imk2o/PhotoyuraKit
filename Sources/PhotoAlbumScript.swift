//
//  PhotoAlbumScript.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit

enum PhotoAlbumScriptError: Error {
    case photoAlbumLoadError(Error)
}

open class PhotoAlbumScript: Script {
    typealias ResultHandler = (Result<PhotoAlbumScript, PhotoAlbumScriptError>) -> Void
    
    public let photos: [Photo]
    public let photoAlbum: PhotoAlbum
    public let configuration: Configuration
    internal(set) var currentIndex: Int?
    
    init(photos: [Photo], in photoAlbum: PhotoAlbum, configuration: Configuration) {
        self.photos = photos
        self.photoAlbum = photoAlbum
        self.configuration = configuration
    }

    static func script(
        with photoAlbum: PhotoAlbum,
        configuration: Configuration,
        completion handler: @escaping ResultHandler)
    {
        let loader = photoAlbum.loader()
        
        let options = SystemPhotoAlbumLoadOptions()		// FIXME
        loader.load(with: options) { (result) in
            switch result {
            case .success(let photos):
                let script = PhotoAlbumScript(photos: photos, in: photoAlbum, configuration: configuration)
                handler(.success(script))
            case .failure(let error):
                handler(.failure(.photoAlbumLoadError(error)))
            }
        }
    }
    
    // MARK: - Script
    
    open func stage() -> Stage {
        return PhotoAlbumStage(
            photoAlbum: self.photoAlbum,
            configuration: self.configuration.stageConfiguration
        )
    }
    
    open func presenter(forNext: Bool) -> Presenter? {
        let index: Int
        if let currentIndex = self.currentIndex {
            index = forNext ? currentIndex + 1 : currentIndex
        } else {
            index = 0
        }
        
        guard index < self.photos.count else {
            return nil
        }

        defer {
            self.currentIndex = index
        }
        
        let photo = self.photos[index]
        let direction = self.configuration.presenterDirection
        return PhotoPresenter(photo: photo, direction: direction)
    }
    
    // MARK: - Configuration
    
    public struct Configuration {
        public let name: String
        
        public let presenterDirection: PhotoPresenter.Direction
        public let stageConfiguration: PhotoAlbumStage.Configuration	// FIXME: Direction
    }
}
