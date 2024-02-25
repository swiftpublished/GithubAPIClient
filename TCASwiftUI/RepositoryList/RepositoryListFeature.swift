//
//  RepositoryListFeature.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

@Reducer
public struct RepositoryListFeature {
    @ObservableState
    public struct State: Equatable {
        public var repos: IdentifiedArrayOf<RepositoryRowFeature.State>
        public var isLoading: Bool
        public var errorMessage: String?
        
        public init(
            repos: IdentifiedArrayOf<RepositoryRowFeature.State> = [],
            isLoading: Bool = true,
            errorMessage: String? = nil
        ) {
            self.repos = repos
            self.isLoading = isLoading
        }
    }
    
    public enum Action: Equatable {
        case fetchRepos
        case reposResponse(TaskResult<Repositories>)
        case repos(IdentifiedActionOf<RepositoryRowFeature>)
    }
    
    @Dependency(\.repositoryClient) var repositoryClient
    
    public init() {  }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .fetchRepos:
                state.isLoading = true
                
                return .run { send in
                    await send(
                        .reposResponse(
                            TaskResult { try await repositoryClient.repos() }
                        )
                    )
                }
                
            case let .reposResponse(.success(repos)):
                state.isLoading = false
                let repoStates = repos.map(RepositoryRowFeature.State.init(repo:))
                state.repos = IdentifiedArray(uniqueElements: repoStates)
                return .none
                
            case let .reposResponse(.failure(error)):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none
                
            case .repos:
                return .none
            }
        }
        .forEach(\.repos, action: \.repos) {
            RepositoryRowFeature()
        }
    }
}
