//
//  SystemPhotoContentLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import Photos

public extension PhotoContentLoadOptions {
    public enum SystemRespondAs {
        case original
        case image
        case video
    }
    
    enum SystemExtraKey: String {
        case respondAs
    }
    
    public var systemRespondAs: SystemRespondAs {
        get {
            return (self.extra[SystemExtraKey.respondAs] as? SystemRespondAs) ?? .original
        } set {
            self.extra[SystemExtraKey.respondAs] = newValue
        }
    }
    
    public init(
        systemRespondAs: SystemRespondAs = .original,
        imagePreferredSize: CGSize = .zero,
        imageContentMode: ImageContentMode = .aspectFit
    ) {
        self.imagePreferredSize = imagePreferredSize
        self.imageContentMode = imageContentMode

        self.systemRespondAs = systemRespondAs
    }
    
    var phImageRequestOptions: PHImageRequestOptions {
        let options = PHImageRequestOptions()

        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        return options
    }
    
    var phVideoRequestOptions: PHVideoRequestOptions {
        let options = PHVideoRequestOptions()

        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        
        return options
    }
    
    var phLivePhotoRequestOptions: PHLivePhotoRequestOptions {
        let options = PHLivePhotoRequestOptions()

        options.isNetworkAccessAllowed = true
        options.deliveryMode = .highQualityFormat
        
        return options
    }
}

public extension PhotoContentLoadOptions.ImageContentMode {
    var phImageContentMode: PHImageContentMode {
        switch self {
        case .aspectFill:
            return .aspectFill
        case .aspectFit:
            return .aspectFit
        }
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
    ) -> PhotoContentLoader.RequestID {
        switch options.systemRespondAs {
        case .original:
            switch self.photo.photoType {
            case .image:
                return self.loadImage(with: options, completion: handler)
            case .video:
                return self.loadVideo(with: options, completion: handler)
            case .livePhoto:
                return self.loadLivePhoto(with: options, completion: handler)
            case .unknown:
                handler(.failure(.unknown))
                return false
            }
        case .image:
            return self.loadImage(with: options, completion: handler)
        case .video:
            if self.photo.photoType == .livePhoto {
                return self.loadLivePhoto(with: options, completion: handler)
            } else {
                return self.loadVideo(with: options, completion: handler)
            }
        }
    }
    
    func cancel(requestID: PhotoContentLoader.RequestID) {
        guard let phImageRequestID = requestID as? PHImageRequestID else {
            return
        }
        
        self.sharedImageManager.cancelImageRequest(phImageRequestID)
    }
    
    private func loadImage(
        with options: PhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    ) -> Any {
        return self.sharedImageManager.requestImage(
            for: self.photo.asset,
            targetSize: options.imagePreferredSize,
            contentMode: options.imageContentMode.phImageContentMode,
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
                } else if let cancelled = info?[PHImageCancelledKey] as? Bool, cancelled {
                    handler(.failure(.cancelled))
                } else {
                    handler(.failure(.unknown))
                }
            }
        }
    }
    
    private func loadVideo(
        with options: PhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    ) -> Any {
        return self.sharedImageManager.requestAVAsset(
            forVideo: self.photo.asset,
            options: options.phVideoRequestOptions
        ) { (videoAsset, _, info) in
            if let videoAsset = videoAsset {
                handler(.success(.video(videoAsset)))
            } else if let error = info?[PHImageErrorKey] as? Error {
                handler(.failure(.systemError(error)))
            } else if let cancelled = info?[PHImageCancelledKey] as? Bool, cancelled {
                handler(.failure(.cancelled))
            } else {
                handler(.failure(.unknown))
            }
        }
    }
    
    private func loadLivePhoto(
        with options: PhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    ) -> Any {
        return self.sharedImageManager.requestLivePhoto(
            for: self.photo.asset,
            targetSize: options.imagePreferredSize,
            contentMode: options.imageContentMode.phImageContentMode,
            options: options.phLivePhotoRequestOptions
        ) { (livePhoto, info) in
            if let livePhoto = livePhoto {
                if
                    let videoAsset = livePhoto.value(forKey: "videoAsset") as? AVAsset,
                    options.systemRespondAs == .video
                {
                    // 動画として返す
                    handler(.success(.video(videoAsset)))
                } else {
                    handler(.success(.livePhoto(livePhoto)))
                }
            } else if let error = info?[PHImageErrorKey] as? Error {
                handler(.failure(.systemError(error)))
            } else if let cancelled = info?[PHImageCancelledKey] as? Bool, cancelled {
                handler(.failure(.cancelled))
            } else {
                handler(.failure(.unknown))
            }
        }
    }
}
