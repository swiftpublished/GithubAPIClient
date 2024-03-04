//
//  Root.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

import ComposableArchitecture

public struct Root: View {
    @Perception.Bindable var store: StoreOf<AppFeature>

    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                RepositoryList(
                    store: store.scope(
                        state: \.repositoryList,
                        action: \.repositoryList
                    )
                )
                .navigationTitle("Repositories")
                .navigationBarTitleDisplayMode(.large)
            } destination: { store in
                switch store.case {
                case .repositoryDetail(let store):
                    RepositoryDetail(store: store)
                }
            }
        }
    }
}
