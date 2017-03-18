//
//  PhotoAlbumContentsLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

/// 写真アルバムの写真読み込みオプション。
public protocol PhotoAlbumLoadOptions {
    
}

/// 写真アルバムの読み込みエラー。
public enum PhotoAlbumLoadError: Error {
    
}

/// 写真アルバム内の写真読み込み機能を提供する。
public protocol PhotoAlbumContentsLoader {
    init(album: PhotoAlbum)
    
    /// 写真を読み込む。
    ///
    /// - Parameters:
    ///   - options: オプション。
    ///   - handler: 結果ハンドラ。
    func load(
        with options: PhotoAlbumLoadOptions,
        completion handler: (Result<[Photo], PhotoAlbumLoadError>) -> Void
    )
}
