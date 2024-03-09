//
//  RepositoryRowFeature.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

@Reducer
public struct RepositoryRowFeature {
    @ObservableState
    public struct State: Identifiable, Equatable {
        public var id: Int { repo.id }
        
        var repo: Repository

        public init(repo: Repository) {
            self.repo = repo
        }
    }
    
    public enum Action: Equatable {
        case starButtonTapped
    }
    
    public var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .starButtonTapped:
                state.repo.isStarred.toggle()
                return .none
            }
        }
    }
}
