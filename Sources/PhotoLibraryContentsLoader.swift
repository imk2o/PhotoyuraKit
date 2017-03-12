//
//  PhotoLibraryContentsLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

public protocol PhotoLibraryLoadOptions {
    
}

public enum PhotoLibraryLoadError: Error {
    
}

public protocol PhotoLibraryContentsLoader {
    init(library: PhotoLibrary)
    
    func load(
        with options: PhotoLibraryLoadOptions,
        completion handler: (Result<[PhotoAlbum], PhotoLibraryLoadError>) -> Void
    )
}
