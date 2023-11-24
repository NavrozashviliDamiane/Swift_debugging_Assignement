//
//Static Shared Instance: Changed let shared = NetworkManager() to static let shared = NetworkManager(). This ensures that shared is a static property of the NetworkManager class, allowing access to the shared instance through NetworkManager.shared.
//URL Initialization: Updated the URL initialization in the get function by using the provided URL string rather than an empty string.

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func get<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
            
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}


