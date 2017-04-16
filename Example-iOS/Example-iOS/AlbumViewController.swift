//
//  AlbumViewController.swift
//  Example-iOS
//
//  Created by k2o on 2017/03/18.
//  Copyright © 2017年 imk2o. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import PhotoyuraKit

class AlbumViewController: UIViewController {
    var photoAlbum: PhotoAlbum!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadAlbumContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showImage"?:
            guard
                let imageViewController = segue.destination as? ImageViewController,
                let indexPath = self.collectionView.indexPathsForSelectedItems?.first
            else {
                break
            }
            
            imageViewController.photo = self.photo(at: indexPath)
        case "showLivePhoto"?:
            guard
                let livePhotoViewController = segue.destination as? LivePhotoViewController,
                let indexPath = self.collectionView.indexPathsForSelectedItems?.first
                else {
                    break
            }
            
            livePhotoViewController.photo = self.photo(at: indexPath)
        case "play"?:
            guard let playerViewController = segue.destination as? PlayerViewController else {
                break
            }
            
            playerViewController.photoAlbum = self.photoAlbum
        default:
            break
        }
    }
}

private extension AlbumViewController {
    func loadAlbumContents() {
        let loader = self.photoAlbum.loader()
        let options = SystemPhotoAlbumLoadOptions()
        loader.load(with: options) { [weak self] (result) in
            switch result {
            case .success(let photos):
                self?.photos = photos
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func photo(at indexPath: IndexPath) -> Photo {
        return self.photos[indexPath.item]
    }
    
    func presentVideoPlayer(with photo: Photo) {
        let loader = photo.loader()
        let options = SystemPhotoContentLoadOptions(respondAs: .video)
        loader.load(with: options) { [weak self] (result) in
            switch result {
            case .success(let content):
                if case .video(let videoAsset) = content {
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = AVPlayer(playerItem: AVPlayerItem(asset: videoAsset))
                    
                    self?.present(playerViewController, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// Storyboardの設定
// * CollecetionViewControllerのView直下にUICollectionViewを配置
//     * `collectionView`としてIBOutletを作成
//     * Section Headerをオン
//     * UICollectionReusableViewのReuse Identifierを"Header"に
//     * UICollectionViewCellのReuse Identifierを"Cell"に
// * dataSource, delegateをCollectionViewControllerに設定

extension AlbumViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1	// FIXME
    }
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionElementKindSectionHeader:
//            guard let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Header", forIndexPath: indexPath) as? UICollectionReusableView else {
//                fatalError()
//            }
//            
//            // FIXME: configure header view
//            headerView.backgroundColor = UIColor.grayColor()
//            
//            return headerView
//        case UICollectionElementKindSectionFooter:
//            fatalError()
//        default:
//            fatalError()
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? AlbumPhotoCell else {
            fatalError()
        }
        
        let photo = self.photo(at: indexPath)
        cell.configure(with: photo)
        
        return cell
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    private var numberOfColumns: Int {
        return 4	// FIXME
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError()
        }
        
        // 画面サイズに関係なく、列数がnumberOfColumnsになるよう、セルサイズを調整
        let numberOfSpaces = self.numberOfColumns - 1
        let size = (self.view.bounds.width - (flowLayout.minimumInteritemSpacing * CGFloat(numberOfSpaces))) / CGFloat(self.numberOfColumns)
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let photo = self.photo(at: indexPath)
        switch photo.photoType {
        case .image:
            self.performSegue(withIdentifier: "showImage", sender: self)
        case .video:
            self.presentVideoPlayer(with: photo)
        case .livePhoto:
            self.performSegue(withIdentifier: "showLivePhoto", sender: self)
        default:
            break
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
