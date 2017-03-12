//
//  Result.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import Foundation

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
