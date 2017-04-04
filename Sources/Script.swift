//
//  Script.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/22.
//
//

import UIKit

public protocol Script {
    func stage() -> Stage
    func presenter(forNext: Bool) -> Presenter?
}
