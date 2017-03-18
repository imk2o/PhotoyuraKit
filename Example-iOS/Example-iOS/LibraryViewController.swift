//
//  LibraryViewController.swift
//  Example-iOS
//
//  Created by k2o on 2017/03/18.
//  Copyright © 2017年 imk2o. All rights reserved.
//

import UIKit
import PhotoyuraKit

class LibraryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var photoLibrary: PhotoLibrary?
    fileprivate var photoAlbums: [PhotoAlbum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.authAndLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAlbum"?:
            guard
                let albumViewController = segue.destination as? AlbumViewController,
                let indexPath = self.tableView.indexPathForSelectedRow
            else {
                break
            }

            albumViewController.photoAlbum = self.photoAlbum(at: indexPath)
        default:
            break
        }
    }
}

private extension LibraryViewController {
    func authAndLoad() {
        let auth = SystemPhotoLibraryAuthorization()
        
        auth.request { [weak self] (result) in
            switch result {
            case .success(let photoLibrary):
                self?.photoLibrary = photoLibrary
                self?.loadLibrary()
            case .failure(let error):
                print(error)
            }
        }
    }

    func loadLibrary() {
        guard let photoLibrary = self.photoLibrary else {
            return
        }

        let loader = photoLibrary.loader()
        let options = SystemPhotoLibraryLoadOptions()
        loader.load(with: options) { [weak self] (result) in
            switch result {
            case .success(let photoAlbums):
                self?.photoAlbums = photoAlbums
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func photoAlbum(at indexPath: IndexPath) -> PhotoAlbum {
        return self.photoAlbums[indexPath.row]
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension LibraryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.photoAlbums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let photoAlbum = self.photoAlbum(at: indexPath)
        cell.textLabel?.text = photoAlbum.title
        cell.detailTextLabel?.text = photoAlbum.numberOfPhotos.map { "\($0) photos" } ?? ""
        
        return cell
    }
}

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
