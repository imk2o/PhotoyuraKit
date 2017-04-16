//
//  PlayerViewController.swift
//  Example-iOS
//
//  Created by k2o on 2017/04/16.
//  Copyright © 2017年 imk2o. All rights reserved.
//

import UIKit
import SpriteKit
import PhotoyuraKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var skView: SKView!

    var photoAlbum: PhotoAlbum!

    fileprivate var player: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let configuration = PhotoAlbumScript.Configuration(
            name: "example",
            presenterDirection: PhotoPresenter.Direction(
                transition: DissolvePhotoTransition(),
                filter: VignettePhotoFilter()
            ),
            stageDirection: PhotoAlbumStage.Direction()
        )

        PhotoAlbumScript.script(
            with: self.photoAlbum,
            configuration: configuration
        ) { (result) in
            switch result {
            case .success(let script):
                self.player = Player(view: self.skView, script: script)
                self.player.perform(action: .play)
            case .failure(let error):
                print(error)		// FIXME
            }
        }
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

    @IBAction func closeButtonDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
}
