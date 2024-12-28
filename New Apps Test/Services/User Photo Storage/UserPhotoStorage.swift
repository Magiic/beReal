//
//  UserPhotoStorage.swift
//  New Apps Test
//
//  Created by Haïthem Ben Harzallah on 27/12/2024.
//

import AppStorage
import Foundation
import UIKit

protocol UserPhotoStorage: Sendable {
    
    func storePhotoFiltered(photo: UIImage) async throws
    
    func fetch() async throws -> UserPhotoCollection
}

enum UserPhotoStorageError: Error {
    case imageToData
}

actor AppUserPhotoStorage: UserPhotoStorage {
    private let storageKey = "AppUserPhotoStorageKey"
    
    func storePhotoFiltered(photo: UIImage) async throws {
        guard let data = photo.pngData() else {
            throw UserPhotoStorageError.imageToData
        }
        
        let localStorage = LocalUserDefaultsStorage(userDefaults: UserDefaults.standard)
        
        var collection = try await fetch()
        collection.photos += [
            UserPhoto(id: UUID(), photo: data, date: Date())
        ]
        
        try localStorage.store(collection, forKey: storageKey, encoder: JSONEncoder())
    }
    
    func fetch() async throws -> UserPhotoCollection {
        let localStorage = LocalUserDefaultsStorage(userDefaults: UserDefaults.standard)
        let collection: UserPhotoCollection? = try localStorage.get(key: storageKey, decoder: JSONDecoder())
        
        return collection ?? UserPhotoCollection(photos: [])
    }
}
