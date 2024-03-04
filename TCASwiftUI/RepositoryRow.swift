//
//  RepositoryRow.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct RepositoryRow: View {
    let store: StoreOf<RepositoryRowFeature>

    public init(store: StoreOf<RepositoryRowFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            NavigationLink(
                state: AppFeature.Path.State.repositoryDetail(
                    RepositoryDetailFeature.State(repo: store.repo)
                )
            ) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 8) {
                        AsyncImage(url: URL(string: store.repo.owner.avatarURL)) { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                        } placeholder: {
                            Color.gray
                                .frame(width: 40, height: 40)
                                .cornerRadius(8)
                                .opacity(0.2)
                        }

                        Text(store.repo.name)
                            .font(.headline)

                        Spacer()

                        Button {
                            store.send(.starButtonTapped)
                        } label: {
                            Image(systemName: store.repo.isStarred ? "heart.fill" : "heart")
                                .foregroundColor(.yellow)
                        }
                        .buttonStyle(.plain)
                    }

                    store.repo.description.map(Text.init(_:))
                        .lineLimit(2)
                }
            }
        }
    }
}
