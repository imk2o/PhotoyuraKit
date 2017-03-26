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
    func load(to: Scene, completion handler: @escaping (Result<Void, StageLoadError>) -> Void) -> Any?
    func cancel(identifier: Any)
    func present(in: Scene, time: Time)
    func unload(from: Scene)
}
