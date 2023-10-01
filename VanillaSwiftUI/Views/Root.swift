//
//  Root.swift
//  VanillaSwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct Root: View {
    @ObservedObject var model: RepositoriesListModel
    
    public init(model: RepositoriesListModel) {
        self.model = model
    }
    
    public var body: some View {
        NavigationStack {
            RepositoryList(repos: $model.repos)
                .navigationTitle("Repositories")
                .navigationDestination(for: Repository.self) { repo in
                    RepositoryDetail(repo: binding(for: repo.id))
                }
        }
        .searchable(
            text: $model.searchText,
            prompt: "Search Github"
        )
        .task {
            await model.loadData()
        }
    }
    
    private func binding(for id: Int) -> Binding<Repository> {
        Binding(
            get: {
                model.repos.first(where: { repo in repo.id == id })!
            },
            set: { updatedRepo in
                model.repos = model.repos.map { repo in
                    if repo.id == updatedRepo.id {
                        return updatedRepo
                    }
                    
                    return repo
                }
            }
        )
    }
}
