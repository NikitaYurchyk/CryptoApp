//
//  HomeView.swift
//  CryptoApp
//
//  Created by Nikita on 01/04/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var isPresentingDetail = false
    @State private var selectedItem: CoinInfo?

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    homeHeader
                    CustomSearchBar(text: $vm.searchBar)
                    Spacer()
                    List(vm.filteredRates, id: \.id) { item in
                        Button(action: {
                            self.selectedItem = item
                            self.isPresentingDetail = true
                        }) {
                            HStack {
                                Text(item.symbol)
                                    .bold()
                                Spacer()
                                Text("$ \(String(format: "%.3f", Double(item.priceUsd)!))")
                            }
                        }
                    }
                    
                    
                    .listStyle(.automatic)
                    .task {
                        vm.startAutoRefresh()
                    }
                    .onAppear(perform: {
                        Task {
                            do {
                                print("pressed the button")
                                try await vm.refreshView()
                            } catch {
                                print("Error refreshing view: \(error)")
                            }
                        }
                    })
                    .sheet(item: $selectedItem) { item in
                        CoinInfoView(item: item)
                    }
                }
            }
        }
    }
    
}


#Preview {
    HomeView()
}


extension HomeView {
    private var homeHeader: some View {
        HStack {
            Text("Current Prices")
                .font(.title)
                .foregroundColor(Color.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button(action: {
                Task {
                    do {
                        print("pressed the button")
                        try await vm.refreshView()
                    } catch {
                        print("Error refreshing view: \(error)")
                    }
                }
            }) {
                CircleButtonView(nameOfIcon: "arrow.clockwise")
            }
            .frame(alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

struct CoinInfoView: View{
    @State var item: CoinInfo
    var body: some View{
        VStack{
            HStack{
                Text("\(item.symbol): \(item.id.capitalized(with: .current))")
                    .font(.title)
                Spacer()
                Text("\(String(format: "%.3f", Double(item.priceUsd)!))")
                    .font(.headline)
            }
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Market Cap:\(String(format: "%.3f", Double(item.marketCapUsd)!))")
                Text("Supply \(item.supply)")
            }
        }
    }
}

struct CustomSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search...", text: $text)
                .textFieldStyle(.roundedBorder)

            if !text.isEmpty {
                Button(action: { self.text = "" }) {
                }
            }
        }
        .padding(.trailing)
    }
}
