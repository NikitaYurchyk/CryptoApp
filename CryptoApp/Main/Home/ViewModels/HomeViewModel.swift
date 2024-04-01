//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Nikita on 01/04/2024.
//
import SwiftUI

extension HomeView {
    @MainActor class HomeViewModel: ObservableObject {
        @Published var data = [CoinInfo]()
        @Published var searchBar = ""
        
        func refreshView() async throws {
            do {
                let rates = try await fetchDataForAllCoins(preview: true)
                withAnimation {
                    self.data = rates.data
                }
                print("Number of entries fetched: ", self.data.count)
            } catch {
                print("Error fetching data: \(error)")
            }
        }
        
        func startAutoRefresh() {
            Task {
                while true {
                    try await reloadData()
                    do {
                        try await Task.sleep(nanoseconds: 30 * 1_000_000_000)
                    } catch {
                        print("Sleep interrupted: \(error)")
                        break
                    }
                }
            }
        }
        
        func reloadData() async throws {
            let rates = try await fetchDataForAllCoins(preview: true)
            withAnimation {
                print("Data updated")
                self.data = rates.data
            }
        }
        
        
        var filteredRates: [CoinInfo] {
            searchBar.isEmpty ? data : data.filter { $0.symbol.contains(searchBar.uppercased()) }
        }
    }
    
    
}
