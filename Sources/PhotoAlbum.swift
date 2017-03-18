//
//  PhotoAlbum.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

/// 写真アルバムを表現するモデル。
public protocol PhotoAlbum {
    var identifier: String { get }
    var title: String { get }
    var numberOfPhotos: Int? { get }
    
    /// アルバム内の写真を読み込むローダを取得する。
    ///
    /// - Returns: ローダを返す。
    func loader() -> PhotoAlbumContentsLoader
}
