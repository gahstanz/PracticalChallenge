//
//  RandomUserAPIManager.swift
//  PracticalChallenge
//
//  Created by Deane Karsten on 11/08/22.
//

import Foundation
import UIKit

enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}

struct RandomUserAPIManager {
    static let shared = RandomUserAPIManager()
    
    func getUsers(page: Int? = nil, results: Int = 10, completion: @escaping (Result<[User], APIError>) -> Void) {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "randomuser.me"
        components.path = "/api"
        components.queryItems = [
            URLQueryItem(name: "page", value: (page != nil) ? "\(page!)" : ""),
            URLQueryItem(name: "results", value: "\(results)"),
            URLQueryItem(name: "seed", value: "celo") // consistent seed "CELO"
        ]

        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }

        print(url.absoluteURL)
        
        let urlRequest = URLRequest(url: url, timeoutInterval: 10)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                print("dataTask error: \(error!.localizedDescription)")
                completion(.failure(.failed(error: error!)))
            } else if let data = data {
                // Success request
                do {
                    // Decode into array of User
                    let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                    let users = userResponse.results ?? []
                    print("success")
                    //print(users)
                    completion(.success(users))
                    
                } catch {
                    // Send error when decoding
                    print("decoding error")
                    completion(.failure(.errorDecode))
                }
            } else {
                print("uknown dataTask error")
                completion(.failure(.unknownError))
            }
        }
        .resume()
    }
    
    func getImageByURL(imageURL: String, imageView: UIImageView) {
        // Get images
        if let url = URL(string: imageURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }

}


