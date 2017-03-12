//
//  PhotoContentLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import AVFoundation
import Photos

public protocol PhotoContentLoadOptions {
    
}

public enum PhotoContentLoadError: Error {
    case systemError(Error)
    case unknown
}

/// 写真の中身。
public enum PhotoContent {
    case image(UIImage)
    case video(AVURLAsset)
    case livePhoto(PHLivePhoto)
}

/// 写真の中身を読み込む。
public protocol PhotoContentLoader {
    init(photo: Photo)
    
    func load(
        with options: PhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    )
}

struct SystemOptions: PhotoContentLoadOptions {
    enum Option {
        case foo
        case bar
    }
    
    let options: [Option]
    
    init(_ options: [Option]) {
        self.options = options
    }
}
