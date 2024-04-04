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
    @State private var selectedItem: CoinModel?
    
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
                        })
                        {
                            HStack {
                                AsyncImage(url: URL(string: item.image)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 30, height: 30)
                                
                                Text(item.symbol.uppercased())
                                    .bold()
                                Spacer()
                                Text("$ \(String(format: "%.3f", item.currentPrice))")
                            }
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
                            print("done automatic refresh crypto info")
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
                        print("pressed a refresh button")
                        try await vm.refreshView()
                    } catch {
                        print("Error refreshing view: \(error)")
                    }
                }
            }) {
                RefreshButton(nameOfIcon: "arrow.clockwise")
            }
            .frame(alignment: .trailing)
        }
        .padding(.horizontal)
    }
}

struct CoinInfoView: View{
    @State var item: CoinModel
    var body: some View{
        VStack{
            HStack{
                Text("\(item.symbol) \(item.id.capitalized(with: .current))")
                    .font(.title)
                Spacer()
                Text("\(String(format: "%.3f", item.currentPrice))")
                    .font(.title)
            }
            .padding(40)

            VStack{
                Text("Market Cap: \(item.marketCap)")
                Text("Supply \(item.totalSupply!)")
            }
            .padding(40)

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
