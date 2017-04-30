//
//  Stage.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit
import SpriteKit

public enum StageLoadError: Error {
    
}

public protocol Stage {
    // FIXME: PresenterのようにContextを介するように
    func load(to: SceneContext, completion handler: @escaping (Result<StageNodeContext, StageLoadError>) -> Void) -> Any?
    func cancel(identifier: Any)
    func present(context: StageNodeContext)
    func unload(context: StageNodeContext)
}
