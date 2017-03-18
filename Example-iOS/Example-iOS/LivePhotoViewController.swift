//
//  LivePhotoViewController.swift
//  Example-iOS
//
//  Created by k2o on 2017/03/18.
//  Copyright © 2017年 imk2o. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import PhotoyuraKit

class LivePhotoViewController: UIViewController {
    var photo: Photo!
    
    @IBOutlet weak var livePhotoView: PHLivePhotoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadLivePhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

private extension LivePhotoViewController {
    func loadLivePhoto() {
        let loader = self.photo.loader()
        let options = SystemPhotoContentLoadOptions(
            imageTargetSize: self.livePhotoView.bounds.size,
            imageContentMode: .aspectFit
        )
        
        loader.load(with: options) { [weak self] (result) in
            switch result {
            case .success(let content):
                if case .livePhoto(let livePhoto) = content {
                    self?.livePhotoView.livePhoto = livePhoto
                    self?.livePhotoView.startPlayback(with: .full)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
