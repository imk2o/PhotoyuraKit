//
//  SystemPhotoAlbumContentsLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import Photos

public struct SystemPhotoAlbumLoadOptions: PhotoAlbumLoadOptions {
    public init() {
    }
}

struct SystemPhotoAlbumContentsLoader: PhotoAlbumContentsLoader {
    private let album: SystemPhotoAlbum
    
    init(album: PhotoAlbum) {
        guard let album = album as? SystemPhotoAlbum else {
            fatalError()		// FIXME
        }
        
        self.album = album
    }
    
    func load(
        with options: PhotoAlbumLoadOptions,
        completion handler: (Result<[Photo], PhotoAlbumLoadError>) -> Void
    ) {
        let options = PHFetchOptions()
        //options.sortDescriptors = self.sortDescriptors
        
        let fetchResult = PHAsset.fetchAssets(in: album.assetCollection, options: options)

        let photos = (0..<fetchResult.count).map { SystemPhoto(asset: fetchResult[$0]) }
        
        handler(.success(photos))
    }
}

struct SystemPhoto: Photo {
    let asset: PHAsset
    
    var identifier: String {
        return self.asset.localIdentifier
    }
    
    var photoType: PhotoType {
        switch self.asset.mediaType {
        case .image:
            if self.asset.mediaSubtypes.contains(.photoLive) {
                return .livePhoto
            }
            
            return .image
        case .video:
            return .video
        default:
            return .unknown
        }
    }
    
    var url: URL? {
        return nil
    }
    
    func loader() -> PhotoContentLoader {
        return SystemPhotoContentLoader(photo: self)
    }
}
