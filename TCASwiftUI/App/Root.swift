//
//  Root.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct Root: View {
    let store: StoreOf<AppFeature>
    
    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(
            store.scope(
                state: \.path,
                action: { .path($0) }
            )
        ) {
            RepositoryList(
                store: store.scope(
                    state: \.repositoryList,
                    action: AppFeature.Action.repositoryList
                )
            )
            .navigationTitle("Repositories")
            .navigationBarTitleDisplayMode(.large)
        } destination: { state in
            switch state {
            case .repositoryDetail:
                CaseLet(
                    /AppFeature.Path.State.repositoryDetail,
                     action: AppFeature.Path.Action.repositoryDetail,
                     then: RepositoryDetail.init(store:)
                )
            }
        }
    }
}
