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
        var rows: IdentifiedArrayOf<RepositoryRowFeature.State>
        var isLoading: Bool
        var errorMessage: String?

        public init(
            rows: IdentifiedArrayOf<RepositoryRowFeature.State> = [],
            isLoading: Bool = true,
            errorMessage: String? = nil
        ) {
            self.rows = rows
            self.isLoading = isLoading
        }
    }

    public enum Action {
        case fetchRepos
        case reposResponse(Result<Repositories, Error>)

        case rows(IdentifiedActionOf<RepositoryRowFeature>)
    }

    @Dependency(\.repositoryClient) var repositoryClient

    public init() {  }

    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .fetchRepos:
                state.isLoading = true

                return .run { send in
                    do {
                        let repos = try await repositoryClient.repos()
                        await send(.reposResponse(.success(repos)))
                    } catch {
                        await send(.reposResponse(.failure(error)))
                    }
                }

            case let .reposResponse(.success(repos)):
                state.isLoading = false
                let repoStates = repos.map(RepositoryRowFeature.State.init(repo:))
                state.rows = IdentifiedArray(uniqueElements: repoStates)
                return .none

            case let .reposResponse(.failure(error)):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none

            case .rows:
                return .none
            }
        }
        .forEach(\.rows, action: \.rows) {
            RepositoryRowFeature()
        }
    }
}
