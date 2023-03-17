//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Elioth Quintana on 15/03/23.
//

import SwiftUI

@available(iOS 13.0, *)
struct AutocompleteSearchBar: View {
    @ObservedObject var searchBarViewModel: SearchBarViewModel
    @Binding var selectedSearchResult: WeatherSearchResult?
    
    @State private var isSearching = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchBarViewModel.searchText)
                    .padding(.leading, 24)
                    .onReceive(searchBarViewModel.$searchText) { searchText in
                        searchBarViewModel.searchPublisher.send(searchText)
                    }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .onTapGesture {
                isSearching = true
            }
            
            if isSearching {
                List(searchBarViewModel.searchResults, id: \.id) { result in
                    Button(action: {
                        selectedSearchResult = result
                        searchBarViewModel.searchText = "\(result.name), \(result.country)"
                        isSearching = false
                    }) {
                        SearchResultRow(searchResult: result)
                    }
                }
                .transition(.move(edge: .top))
                .animation(.easeInOut)
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = UIColor.clear
        }
    }
}

@available(iOS 13.0, *)
struct SearchResultRow: View {
    let searchResult: WeatherSearchResult
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(searchResult.name), \(searchResult.country)")
                .font(.headline)
        }
        .padding(.padding)
    }
}
