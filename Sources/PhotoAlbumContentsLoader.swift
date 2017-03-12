//
//  PhotoAlbumContentsLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

public protocol PhotoAlbumLoadOptions {
    
}

public enum PhotoAlbumLoadError: Error {
    
}


public protocol PhotoAlbumContentsLoader {
    init(album: PhotoAlbum)
    
    func load(
        with options: PhotoAlbumLoadOptions,
        completion handler: (Result<[Photo], PhotoAlbumLoadError>) -> Void
    )
}
