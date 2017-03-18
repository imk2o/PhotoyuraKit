//
//  PhotoLibraryAuthorization.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

/// 写真ライブラリへのアクセス要求エラー。
///
/// - authorizationRequired: ユーザ認証が必要。
public enum PhotoLibraryAuthorizationError: Error {
    case authorizationRequired
}

/// 認証情報。
public protocol PhotoLibraryAuthorizationCredential {
    
}

/// 写真ライブラリへのアクセス要求を提供する。
public protocol PhotoLibraryAuthorization {
    /// 写真ライブラリへのアクセスを要求する。
    ///
    /// - Parameters:
    ///   - credential: 認証情報。
    ///   - handler: 要求結果ハンドラ。
    func request(
        with credential: PhotoLibraryAuthorizationCredential,
        completion handler: @escaping (Result<PhotoLibrary, PhotoLibraryAuthorizationError>) -> Void
    )
}
