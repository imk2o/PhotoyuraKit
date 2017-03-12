//
//  PhotoLibraryAuthorization.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit

public enum PhotoLibraryAuthorizationError: Error {
    case authorizationRequired
}

public protocol PhotoLibraryAuthorizationParameters {
    
}

public protocol PhotoLibraryAuthorization {
    func request(
        with parameters: PhotoLibraryAuthorizationParameters,
        completion handler: (Result<PhotoLibrary, PhotoLibraryAuthorizationError>) -> Void
    )
}
