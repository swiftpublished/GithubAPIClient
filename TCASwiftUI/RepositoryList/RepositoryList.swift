//
//  RepositoryList.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct RepositoryList: View {
    @Perception.Bindable var store: StoreOf<RepositoryListFeature>
    
    public init(store: StoreOf<RepositoryListFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            if store.isLoading {
                ProgressView()
                    .onAppear {
                        store.send(.fetchRepos)
                    }
            } else {
                if let errorMessage = store.errorMessage {
                    Text(errorMessage)
                        .padding(.horizontal, 16)
                        .foregroundColor(.secondary)
                } else {
                    List {
                        ForEachStore(
                            store.scope(
                                state: \.repos,
                                action: \.repo
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
