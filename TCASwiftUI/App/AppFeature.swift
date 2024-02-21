//
//  AppFeature.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

@Reducer
public struct AppFeature {
    @ObservableState
    public struct State: Equatable {
        var path: StackState<Path.State>
        public var repositoryList: RepositoryListFeature.State
        
        public init(
            repositoryList: RepositoryListFeature.State = .init(),
            path: StackState<Path.State> = .init()
        ) {
            self.repositoryList = repositoryList
            self.path = path
        }
    }
    
    public enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case repositoryList(RepositoryListFeature.Action)
    }
    
    public init() {  }
    
    public var body: some ReducerOf<Self> {
        ///
        /// It is important to note that the order of combine ``Scope`` and your additional feature logic
        /// matters. It must be combined before the additional logic. In the other order it would be
        /// possible for the feature to intercept a child action, switch the state to another case, and
        /// then the scoped child reducer would not be able to react to that action. That can cause subtle
        /// bugs, and so we show a runtime warning in that case, and cause test failures.
        ///
        Scope(state: \.repositoryList, action: \.repositoryList) {
            RepositoryListFeature()
        }
        
        Reduce<State, Action> { state, action in
            switch action {
            case let .path(.element(id: id, action: .repositoryDetail(.starButtonTapped))):
                guard case .some(.repositoryDetail(let detailState)) = state.path[id: id] else {
                    return .none
                }
                
                state.repositoryList.repos[id: detailState.repo.id]?.repo = detailState.repo
                return .none
                
            case .repositoryList, .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    public struct Path: Reducer {
        @ObservableState
        public enum State: Equatable {
            case repositoryDetail(RepositoryDetailFeature.State)
        }
        
        public enum Action: Equatable {
            case repositoryDetail(RepositoryDetailFeature.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: \.repositoryDetail, action: \.repositoryDetail) {
                RepositoryDetailFeature()
            }
        }
    }
}
