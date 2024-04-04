//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Nikita on 01/04/2024.
//
import SwiftUI

extension HomeView {
    @MainActor class HomeViewModel: ObservableObject {
        @Published var data = [CoinModel]()
        @Published var searchBar = ""
        
        
        func refreshView() async throws {
            guard !isRateLimited() else {
                print("Fetch skipped due to rate limiting.")
                return
            }
            
            do {
                let rates = try await fetchDataForAllCoins(preview: false)
                withAnimation {
                    self.data = rates
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        private func isRateLimited() -> Bool {
            let defaults = UserDefaults.standard
            let lastFetchKey = "lastFetchTime"
            if let lastFetch = defaults.object(forKey: lastFetchKey) as? Date {
                if Date().timeIntervalSince(lastFetch) < 300 {
                    return true
                }
            }
            defaults.set(Date(), forKey: lastFetchKey)
            return false
        }
        
        
        func startAutoRefresh() {
            Task {
                while true {
                    do {
                        print("Call")
                        try await refreshView()
                        try await Task.sleep(nanoseconds: 300 * 1_000_000_000)
                    } catch {
                        print("Sleep interrupted: \(error)")
                        break
                    }
                }
            }
        }
        
        var filteredRates: [CoinModel] {
            return searchBar.isEmpty ? data : data.filter {
                let result = $0.symbol.contains(searchBar.lowercased())
                return result
            }
        }
    }
}

        
    
    

