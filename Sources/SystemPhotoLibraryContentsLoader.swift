//
//  SystemPhotoLibraryContentsLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import Photos

public struct SystemPhotoLibraryLoadOptions: PhotoLibraryLoadOptions {
    public init() {
    }
}

public struct SystemPhotoLibraryContentsLoader: PhotoLibraryContentsLoader {
    private let library: SystemPhotoLibrary
    
    public init(library: PhotoLibrary) {
        guard let library = library as? SystemPhotoLibrary else {
            fatalError()		// FIXME
        }
        
        self.library = library
    }
    
    public func load(
        with options: PhotoLibraryLoadOptions,
        completion handler: (Result<[PhotoAlbum], PhotoLibraryLoadError>) -> Void
    ) {
        var photoAlbums: [SystemPhotoAlbum] = []
        
        let options = PHFetchOptions()
        photoAlbums += self.fetch(with: .album, subtype: .any, options: options)
        photoAlbums += self.fetch(with: .smartAlbum, subtype: .any, options: options)
        photoAlbums += self.fetch(with: .moment, subtype: .any, options: options)
//        fetchAndAppend(.SmartAlbum, .SmartAlbumUserLibrary, options)
//        fetchAndAppend(.SmartAlbum, .SmartAlbumFavorites, options)
//        fetchAndAppend(.SmartAlbum, .SmartAlbumRecentlyAdded, options)
//        fetchAndAppend(.SmartAlbum, .SmartAlbumPanoramas, options)
//        if #available(iOS 9, *) {
//            fetchAndAppend(.SmartAlbum, .SmartAlbumSelfPortraits, options)
//        }

        handler(.success(photoAlbums))
    }

    func fetch(
        with type: PHAssetCollectionType,
        subtype: PHAssetCollectionSubtype,
        options: PHFetchOptions
    ) -> [SystemPhotoAlbum] {
        let fetchResult = PHAssetCollection.fetchAssetCollections(
            with: type,
            subtype: subtype,
            options: options
        )
        
        return (0..<fetchResult.count).map { SystemPhotoAlbum(assetCollection: fetchResult[$0]) }
    }
}

struct SystemPhotoAlbum: PhotoAlbum {
    let assetCollection: PHAssetCollection
    
    var identifier: String {
        return self.assetCollection.localIdentifier
    }
    
    var title: String {
        return self.assetCollection.localizedTitle ?? ""
    }
    
    var numberOfPhotos: Int? {
        let count = self.assetCollection.estimatedAssetCount
        return count == NSNotFound ? nil : count
    }
    
    func loader() -> PhotoAlbumContentsLoader {
        return SystemPhotoAlbumContentsLoader(album: SystemPhotoAlbum(assetCollection: self.assetCollection))
    }
}
