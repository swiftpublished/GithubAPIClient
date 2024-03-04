//
//  AppFeature.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

@Reducer
public struct AppFeature {
    @Reducer
    public enum Path {
        case repositoryDetail(RepositoryDetailFeature)
    }

    @ObservableState
    public struct State {
        var repositoryList: RepositoryListFeature.State
        var path: StackState<Path.State>

        public init(
            repositoryList: RepositoryListFeature.State = .init(),
            path: StackState<Path.State> = .init()
        ) {
            self.repositoryList = repositoryList
            self.path = path
        }
    }

    public enum Action {
        case repositoryList(RepositoryListFeature.Action)
        case path(StackAction<Path.State, Path.Action>)
    }

    public init() {  }

    public var body: some ReducerOf<Self> {
        Scope(state: \.repositoryList, action: \.repositoryList) {
            RepositoryListFeature()
        }
        .forEach(\.path, action: \.path)
    }
}
