//
//  AlbumPhotoCell.swift
//  Example-iOS
//
//  Created by k2o on 2017/03/18.
//  Copyright © 2017年 imk2o. All rights reserved.
//

import UIKit
import PhotoyuraKit

class AlbumPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    func configure(with photo: Photo) {
        
        let loader = photo.loader()
        let options = PhotoContentLoadOptions(
            systemRespondAs: .image,
            imagePreferredSize: CGSize(width: 100, height: 100),
            imageContentMode: .aspectFill
        )
        loader.load(with: options) { [weak self] (result) in
            switch result {
            case .success(let content):
                if case .image(let image) = content {
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
