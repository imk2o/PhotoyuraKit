//
//  SystemPhotoLibraryAuthorization.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import Photos

public struct SystemPhotoLibraryAuthorizationCredential: PhotoLibraryAuthorizationCredential {
    public init() {
    }
}

public struct SystemPhotoLibraryAuthorization: PhotoLibraryAuthorization {
    public init() {
    }
    
    public func request(
        with credential: PhotoLibraryAuthorizationCredential,
        completion handler: @escaping (Result<PhotoLibrary, PhotoLibraryAuthorizationError>) -> Void
    ) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    handler(.success(SystemPhotoLibrary()))
                }
            case .denied, .restricted, .notDetermined:
                DispatchQueue.main.async {
                    handler(.failure(.authorizationRequired))
                }
            }
        }
    }
}

public extension SystemPhotoLibraryAuthorization {
    public func request(completion handler: @escaping (Result<PhotoLibrary, PhotoLibraryAuthorizationError>) -> Void) {
        return self.request(
            with: SystemPhotoLibraryAuthorizationCredential(),
            completion: handler
        )
    }
}

struct SystemPhotoLibrary: PhotoLibrary {
    func loader() -> PhotoLibraryContentsLoader {
        return SystemPhotoLibraryContentsLoader(library: self)
    }
}
