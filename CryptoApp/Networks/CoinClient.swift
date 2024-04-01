//
//  File.swift
//  CryptoApp
//
//  Created by Nikita on 01/04/2024.
//

import Foundation

let urlName = "https://api.coincap.io/v2/assets"

func fetchDataForSingleCoin(id: String, previewMode: Bool, _ completion:@escaping (CoinModel) -> ()) async throws -> Void {
    print("here1")
    guard let url = URL(string: urlName + id) else {
        throw NSError(domain: "InvalidURL", code: 1, userInfo: nil)
    }
    let request = URLRequest(url: url)
    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let httpResponse = response as? HTTPURLResponse {
        print("Server response: \(httpResponse.statusCode)")
        return
    }
  
    let decodedData = try JSONDecoder().decode(CoinModel.self, from: data)
    completion(decodedData)
    return
}

func fetchDataForAllCoins(preview: Bool) async throws -> CoinsModel {
    guard let url = URL(string: urlName) else {
        throw NSError(domain: "InvalidURL", code: 1, userInfo: nil)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else {
        throw NSError(domain: "HTTPError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Response was not HTTPURLResponse"])
    }
    
    guard httpResponse.statusCode == 200 else {
        throw NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP Status Code: \(httpResponse.statusCode)"])
    }
    
    return try JSONDecoder().decode(CoinsModel.self, from: data)
}
