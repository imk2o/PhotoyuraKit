//
//  Presenter.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit
import SpriteKit

public enum PresenterAction {
    case appear
    case play
    case disappear
}

public enum PresenterLoadError: Error {
    case contentLoadError(Error)
}

public protocol Presenter {
    func duration(for: PresenterAction) -> CGFloat
    
    func load(to: SceneContext, completion handler: @escaping (Result<PhotoNodeContext, PresenterLoadError>) -> Void) -> Any?
    func cancel(identifier: Any)
    func perform(action: PresenterAction, node: PhotoNodeContext, in: SceneContext)
    func unload(node: PhotoNodeContext, from: SceneContext)
}
