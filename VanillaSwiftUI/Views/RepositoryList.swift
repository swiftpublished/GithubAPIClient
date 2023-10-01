//
//  RepositoryList.swift
//  VanillaSwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

struct RepositoryList: View {
    @Binding var repos: Repositories
    
    var body: some View {
        if !repos.isEmpty {
            List {
                ForEach(repos, id: \.id) { repo in
                    NavigationLink(value: repo) {
                        RepositoryRow(repo: binding(for: repo.id))
                    }
                }
            }
            .listStyle(.plain)
        } else {
            ProgressView()
        }
    }
    
    private func binding(for id: Int) -> Binding<Repository> {
        Binding(
            get: {
                repos.first(where: { repo in repo.id == id })!
            },
            set: { updatedRepo in
                repos = repos.map { repo in
                    if repo.id == updatedRepo.id {
                        return updatedRepo
                    }
                    
                    return repo
                }
            }
        )
    }
}
