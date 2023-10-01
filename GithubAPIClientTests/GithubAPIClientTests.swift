//
//  GithubAPIClientTests.swift
//  GithubAPIClientTests
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

import XCTest
@testable import GithubAPIClient

@MainActor
final class GitHubApiClientTests: XCTestCase {
    func testReposSuccessResponse() async throws {
        let repo = Repository(
            id: 1,
            name: "name 1",
            owner: .init(login: "login 1", avatarURL: "avatarURL 1"),
            description: "description 1",
            language: "language 1",
            numberOfStars: 1,
            numberOfForks: 1,
            isStarred: false
        )
        let store = TestStore(initialState: RepositoryListFeature.State()) {
            RepositoryListFeature()
        } withDependencies: { dependencies in
            dependencies.repositoryClient.repos = { [repo] }
        }
        
        await store.send(.fetchRepos)
        
        await store.receive(.reposResponse(.success([repo]))) { state in
            state.isLoading = false
            state.repos = [
                RepositoryRowFeature.State(repo: repo)
            ]
        }
    }
    
    func testReposFailureResponse() async throws {
        struct RepoError: LocalizedError, Equatable {
            var errorDescription: String? { "Test Failure" }
        }
        
        let error = RepoError()
        let store = TestStore(initialState: RepositoryListFeature.State()) {
            RepositoryListFeature()
        } withDependencies: { dependencies in
            dependencies.repositoryClient.repos = { throw RepoError() }
        }
        
        await store.send(.fetchRepos)
        
        await store.receive(.reposResponse(.failure(error))) { state in
            state.isLoading = false
            state.errorMessage = "Test Failure"
        }
    }
    
    func testStarringRepo() async throws {
        let repo = Repository(
            id: 1,
            name: "name",
            owner: Owner(login: "login", avatarURL: "avatarURL"),
            description: "description",
            language: "language",
            numberOfStars: 1,
            numberOfForks: 1,
            isStarred: false
        )
        let repos: IdentifiedArrayOf<RepositoryRowFeature.State> = [
            RepositoryRowFeature.State(repo: repo)
        ]
        let store = TestStore(initialState: RepositoryListFeature.State(repos: repos)) {
            RepositoryListFeature()
        }
        
        let id = repo.id
        await store.send(.repo(id: id, action: .starButtonTapped)) { state in
            state.repos[id: id]?.repo.isStarred = true
        }
    }
}
