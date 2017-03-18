//
//  ImageViewController.swift
//  Example-iOS
//
//  Created by k2o on 2017/03/18.
//  Copyright © 2017年 imk2o. All rights reserved.
//

import UIKit
import PhotoyuraKit

class ImageViewController: UIViewController {
    var photo: Photo!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension ImageViewController {
    func loadImage() {
        let loader = self.photo.loader()
        let options = SystemPhotoContentLoadOptions(
            respondAs: .image,
            imageTargetSize: self.imageView.bounds.size,
            imageContentMode: .aspectFit
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
