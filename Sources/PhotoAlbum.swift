//
//  PhotoAlbum.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

public protocol PhotoAlbum {
    var identifier: String { get }
    var title: String { get }
    var numberOfPhotos: Int? { get }
    
    func loader() -> PhotoAlbumContentsLoader
}
