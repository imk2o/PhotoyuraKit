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

/// 写真コンテンツの読み込みオプション。
public struct PhotoContentLoadOptions {
    public enum ImageContentMode {
        case aspectFit
        case aspectFill
    }
    
    public var imagePreferredSize: CGSize
    public var imageContentMode: ImageContentMode

    public mutating func setExtra(value: Any, forKey key: AnyHashable) {
        self.extra[key] = value
    }
    
    public func extraValue(forKey key: AnyHashable) -> Any? {
        return self.extra[key]
    }
    
    var extra: [AnyHashable: Any] = [:]
}

/// 写真コンテンツの読み込みエラー。
///
/// - systemError: システムエラー。
/// - unknown: 不明なエラー。
public enum PhotoContentLoadError: Error {
    case cancelled
    case systemError(Error)
    case unknown
}

/// 写真の中身。
public enum PhotoContent {
    case image(UIImage)
    case video(AVAsset)
    case livePhoto(PHLivePhoto)
}

/// 写真の中身を読み込む機能を提供する。
public protocol PhotoContentLoader {
    typealias RequestID = Any
    
    init(photo: Photo)
    
    /// コンテンツを読み込む。
    ///
    /// - Parameters:
    ///   - options: オプション。
    ///   - handler: 結果ハンドラ。
    /// - Returns: リクエストIDを返す。
    @discardableResult
    func load(
        with options: PhotoContentLoadOptions,
        completion handler: @escaping (Result<PhotoContent, PhotoContentLoadError>) -> Void
    ) -> RequestID
    
    func cancel(requestID: RequestID)
}
