//
//  RepositoryDetailFeature.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct RepositoryDetailFeature: Reducer {
    public struct State: Equatable {
        var repo: Repository
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
