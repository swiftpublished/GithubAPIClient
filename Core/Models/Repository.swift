//
//  Repository.swift
//  Core
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public typealias Repositories = [Repository]

public struct Repository: Codable, Hashable {
    public let id: Int
    public let name: String
    public let owner: Owner
    public let description: String?
    public let language: String?
    public let numberOfStars: Int?
    public let numberOfForks: Int?
    
    public var isStarred: Bool = false
    public let languageColor: Color = .random

    public init(
        id: Int,
        name: String,
        owner: Owner,
        description: String?,
        language: String?,
        numberOfStars: Int?,
        numberOfForks: Int?,
        isStarred: Bool
    ) {
        self.id = id
        self.name = name
        self.owner = owner
        self.description = description
        self.language = language
        self.numberOfStars = numberOfStars
        self.numberOfForks = numberOfForks
        self.isStarred = isStarred
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case description
        case language
        case numberOfStars = "stargazers_count"
        case numberOfForks = "forks_count"
    }
}

public struct Owner: Codable, Hashable {
    public let login: String
    public let avatarURL: String = "https://avatars.githubusercontent.com/u/\(Int.random(in: 1...1000))"

    public init(login: String, avatarURL: String) {
        self.login = login
    }
    
    enum CodingKeys: String, CodingKey {
        case login
    }
}

public extension Repositories {
    static func testData() -> Repositories {
        return [
            Repository.testData(),
            Repository.testData(),
            Repository.testData()
        ]
    }
}

public extension Repository {
    static func testData() -> Repository {
        return Repository(id: Int.random(in: 0...100),
                          name: "swift-core-lib",
                          owner: Owner.testData(),
                          description: "this repo swift-core-lib is from apple",
                          language: "Swift",
                          numberOfStars: 50,
                          numberOfForks: 55,
                          isStarred: true)
    }
}

public extension Owner {
    static func testData() -> Owner {
        return Owner(login: "login", avatarURL: "www.google.com")
    }
}
