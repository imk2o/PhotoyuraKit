//
//  PhotoLibraryContentsLoader.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

/// 写真ライブラリの読み込みオプション。
public protocol PhotoLibraryLoadOptions {
    
}

/// 写真ライブラリの読み込みエラー。
public enum PhotoLibraryLoadError: Error {
    
}

/// 写真ライブラリ内にあるアルバムの読み込み機能を提供する。
public protocol PhotoLibraryContentsLoader {
    init(library: PhotoLibrary)
    
    /// アルバムを読み込む。
    ///
    /// - Parameters:
    ///   - options: オプション。
    ///   - handler: 結果ハンドラ。
    func load(
        with options: PhotoLibraryLoadOptions,
        completion handler: (Result<[PhotoAlbum], PhotoLibraryLoadError>) -> Void
    )
}
