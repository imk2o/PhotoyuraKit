//
//  Result.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import Foundation

/// コールバック等の結果を表現する。
///
/// - success: 成功した場合。その結果となる値を持つ。
/// - failure: 失敗した場合。エラーを持つ。
public enum Result<T, E: Swift.Error> {
    case success(T)
    case failure(E)
    
    public init(value: T) {
        self = .success(value)
    }
    
    public init(error: E) {
        self = .failure(error)
    }
}
