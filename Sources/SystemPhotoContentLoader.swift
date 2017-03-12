//
//  SystemPhotoContentLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import Photos

public struct SystemPhotoContentLoadOptions: PhotoContentLoadOptions {
    public var targetSize: CGSize
    
    public enum ContentMode {
        case aspectFit
        case aspectFill
        
        var phImageContentMode: PHImageContentMode {
            switch self {
            case .aspectFill:
                return .aspectFill
            case .aspectFit:
                return .aspectFit
            }
        }
    }
    public var contentMode: ContentMode
    
    var phImageRequestOptions: PHImageRequestOptions {
        let options = PHImageRequestOptions()
        // FIXME
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        return options
    }
}

struct SystemPhotoContentLoader: PhotoContentLoader {
    private let photo: SystemPhoto
    private static let sharedImageManager = PHCachingImageManager()
    private var sharedImageManager: PHImageManager {
        return type(of: self).sharedImageManager
    }
    
    init(photo: Photo) {
        guard let photo = photo as? SystemPhoto else {
            fatalError()		// FIXME
        }
        
        self.photo = photo
    }
    
    func load(
        with options: PhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    ) {
        guard let options = options as? SystemPhotoContentLoadOptions else {
            fatalError()		// FIXME
        }
        
        self.loadImage(with: options, completion: handler)
    }
    
    private func loadImage(
        with options: SystemPhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    ) -> PHImageRequestID {
        return self.sharedImageManager.requestImage(
            for: self.photo.asset,
            targetSize: options.targetSize,
            contentMode: options.contentMode.phImageContentMode,
            options: options.phImageRequestOptions
        ) { (image, info) in
            if let image = image {
//                var image = image
//                if params.normalizeImageOrientation {
//                    image = image.orientationNormalizedImage()
//                }
                
                handler(.success(.image(image)))
            } else {
                if let error = info?[PHImageErrorKey] as? Error {
                    handler(.failure(.systemError(error)))
                } else {
                    handler(.failure(.unknown))
                }
            }
        }
    }
}
