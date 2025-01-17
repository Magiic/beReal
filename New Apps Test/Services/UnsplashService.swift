//
//  UnsplashService.swift
//  New Apps Test
//
//  Created by Michel-André Chirita on 06/03/2024.
//

/*
 --------------------------------------------------
 -- Voodoo New Apps Tech Test
 -- BOOSTRAP FILE
 -- Feel free to modify or dismiss it as you like !
 --------------------------------------------------
 */

import Foundation

class UnsplashService {
    
    let appId = "575727"
    let accessKey = "8j7cdQS9HM1tfIomk_dUwqrIZ7wnymEECz6xk6OPP6k"
    let baseURL = "https://api.unsplash.com/"
    
    func getFeaturedPhotos() async -> [String] {
        let url = photosUrl()
        do {
            let result = try await URLSession.shared.data(from: url)
            let imageInfos = try JSONDecoder().decode([ImageInfo].self, from: result.0)
            return imageInfos.map { $0.urls.regular }
        } catch {
            AppLogger.featuredPhotos.error("Fetch featured photos failed")
            return []
        }
    }
    
    func photosUrl() -> URL {
        URL(string: baseURL + "/photos/?client_id=" + accessKey)!
    }
}

class ImageInfo: Codable {
    let urls: ImageUrl
}

class ImageUrl: Codable {
    let regular: String
}
