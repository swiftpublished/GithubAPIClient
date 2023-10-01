//
//  RepositoryClient.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct RepositoryClient {
    public var repos: @Sendable () async throws -> Repositories
}

public extension DependencyValues {
    var repositoryClient: RepositoryClient {
        get { self[RepositoryClient.self] }
        set { self[RepositoryClient.self] = newValue }
    }
}

// MARK: - Live API implementation

extension RepositoryClient: DependencyKey {
    public static let liveValue = RepositoryClient(
        repos: {
            let url = URL(string: "https://api.github.com/orgs/apple/repos")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let repos = try JSONDecoder().decode(Repositories.self, from: data)
            return repos
        }
    )
}

// MARK: - Preview & Test implementation

extension RepositoryClient: TestDependencyKey {
    public static let previewValue = Self(
        repos: { .mock }
    )
    
    public static let testValue = Self(
        repos: unimplemented("\(Self.self).repos")
    )
}

public extension Repositories {
    static let mock: Self = [
        Repository(
            id: 1,
            name: "name 1",
            owner: .init(login: "login 1", avatarURL: "avatarURL 1"),
            description: "description 1",
            language: "language 1",
            numberOfStars: 1,
            numberOfForks: 1,
            isStarred: false
        ),
        Repository(
            id: 1,
            name: "name 2",
            owner: .init(login: "login 2", avatarURL: "avatarURL 2"),
            description: "description 2",
            language: "language 2",
            numberOfStars: 2,
            numberOfForks: 2,
            isStarred: false
        )
    ]
}
