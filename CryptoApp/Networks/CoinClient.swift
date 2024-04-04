//
//  File.swift
//  CryptoApp
//
//  Created by Nikita on 01/04/2024.
//

import Foundation



let urlName = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en"



func fetchDataForAllCoins(preview: Bool) async throws -> [CoinModel] {
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
    
    return try JSONDecoder().decode([CoinModel].self, from: data)
}


