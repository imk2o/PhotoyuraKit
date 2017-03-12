//
//  SystemPhotoLibraryAuthorization.swift
//  PhotoyuraKit
//
//  Created by k2o on 2017/03/12.
//
//

import UIKit
import Photos

public struct SystemPhotoLibraryAuthorizationParameters {
}

public struct SystemPhotoLibraryAuthorization {
    func request(
        with parameters: PhotoLibraryAuthorizationParameters,
        completion handler: @escaping (Result<PhotoLibrary, PhotoLibraryAuthorizationError>) -> Void
    ) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                handler(.success(SystemPhotoLibrary()))
            case .denied, .restricted, .notDetermined:
                handler(.failure(.authorizationRequired))
            }
        }
    }
}

struct SystemPhotoLibrary: PhotoLibrary {
    func loader() -> PhotoLibraryContentsLoader {
        return SystemPhotoLibraryContentsLoader(library: self)
    }
}
