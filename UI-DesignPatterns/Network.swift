//
//  Network.swift
//  UI-DesignPatterns
//
//  Created by Sparkout on 13/06/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(page: Int, completion: @escaping ([Item]?, Error?) -> Void) {
        print("Fetching data for page \(page)")
        let urlString = "https://fakestoreapi.com/products/" // Update with your actual API endpoint
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(nil, NSError(domain: "Invalid response", code: -2, userInfo: nil))
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: -3, userInfo: nil))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Item].self, from: data)
                print("Items decoded:", items)
                completion(items, nil)
            } catch {
                print("Error decoding data:", error)
                completion(nil, error)
            }
        }
        task.resume()
    }
}

