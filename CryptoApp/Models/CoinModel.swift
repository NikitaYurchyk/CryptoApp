//
//  File.swift
//  CryptoApp
//
//  Created by Nikita on 01/04/2024.
//

import Foundation

struct CoinsModel: Codable{
    let data: [CoinInfo]
    let timestamp: UInt64
}

struct CoinModel: Codable{
    let data: CoinInfo
    let timestamp: UInt64
}

struct CoinInfo: Codable, Identifiable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String?
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    let changePercent24Hr: String
    let vwap24Hr: String?
}
