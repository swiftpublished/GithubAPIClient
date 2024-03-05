//
//  RepositoryList.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct RepositoryList: View {
    let store: StoreOf<RepositoryListFeature>

    public init(store: StoreOf<RepositoryListFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            if store.isLoading {
                ProgressView()
                    .onAppear { store.send(.fetchRepos) }
            } else {
                if let errorMessage = store.errorMessage {
                    Text(errorMessage)
                        .padding(.horizontal, 16)
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEach(store.scope(state: \.rows, action: \.rows)) { store in
                            RepositoryRow(store: store)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}
