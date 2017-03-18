//
//  Photo.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

/// 写真タイプ。
public enum PhotoType {
    case image
    case video
    case livePhoto
    case unknown
}

/// 写真を表現するモデル。
public protocol Photo {
    /// ID。
    var identifier: String { get }
    /// 写真タイプ。
    var photoType: PhotoType { get }
    /// 写真のURL。
    var url: URL? { get }
    
    /// 写真内のコンテンツを読み込むローダを取得する。
    ///
    /// - Returns: ローダを返す。
    func loader() -> PhotoContentLoader
}
