//
//  PhotoLibrary.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

/// 写真ライブラリを表現するモデル。
public protocol PhotoLibrary {
    /// ライブラリ内のアルバムを読み込むローダを取得する。
    ///
    /// - Returns: ローダを返す。
    func loader() -> PhotoLibraryContentsLoader
}
