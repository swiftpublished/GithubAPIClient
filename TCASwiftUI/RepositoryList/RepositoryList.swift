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
        WithViewStore(store, observe: { $0 }) { viewStore in
            if viewStore.isLoading {
                ProgressView()
                    .onAppear {
                        store.send(.fetchRepos)
                    }
            } else {
                if let errorMessage = viewStore.errorMessage {
                    Text(errorMessage)
                        .padding(.horizontal, 16)
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEachStore(
                            store.scope(
                                state: \.repos,
                                action: RepositoryListFeature.Action.repo
                            )
                        ) { store in
                            RepositoryRow(store: store)
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
    }
}
