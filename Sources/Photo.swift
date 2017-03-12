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

public protocol Photo {
    var identifier: String { get }
    var photoType: PhotoType { get }
    var url: URL? { get }
    
    func loader() -> PhotoContentLoader
}
