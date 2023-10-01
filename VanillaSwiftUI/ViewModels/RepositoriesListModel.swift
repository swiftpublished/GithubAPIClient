//
//  RepositoriesListModel.swift
//  VanillaSwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

@MainActor
public class RepositoriesListModel: ObservableObject {
    @Published var repos: Repositories = []
    @Published var searchText = ""
    private var apiResponse: Repositories = []
    
    public init() {  }
    
    func loadData() async {
        guard let url = URL(string: "https://api.github.com/orgs/apple/repos") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder()
                .decode(Repositories.self, from: data) {
                apiResponse = decodedResponse
                repos = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
}
