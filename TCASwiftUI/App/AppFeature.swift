//
//  AppFeature.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//
@Reducer
public struct AppFeature {
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

        Reduce<State, Action> { state, action in
            switch action {
            case let .path(.element(id: id, action: .repositoryDetail(.starButtonTapped))):
                guard case .some(.repositoryDetail(let detailState)) = state.path[id: id] else {
                    return .none
                }

                state.repositoryList.rows[id: detailState.repo.id]?.repo = detailState.repo
                return .none

            case .repositoryList, .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AppFeature {
    @Reducer
    public enum Path {
        case repositoryDetail(RepositoryDetailFeature)
    }
}
