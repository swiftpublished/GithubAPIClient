//
//  RepositoryDetail.swift
//  TCASwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

public struct RepositoryDetail: View {
    let store: StoreOf<RepositoryDetailFeature>
    
    public init(store: StoreOf<RepositoryDetailFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: store.repo.owner.avatarURL)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        } placeholder: {
                            Color.gray
                                .frame(width: 100, height: 100)
                                .opacity(0.2)
                                .cornerRadius(8)
                        }
                        
                        Text(store.repo.name)
                            .font(.callout)
                        
                        Spacer()
                        
                        Button {
                            store.send(.starButtonTapped)
                        } label: {
                            Image(systemName: store.repo.isStarred ? "heart.fill" : "heart")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                    store.repo.description.map(Text.init(_:))

                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(store.repo.numberOfStars?.description ?? "")
                                .font(.caption)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.triangle.branch")
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(store.repo.numberOfForks?.description ?? "")
                                .font(.caption)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(store.repo.languageColor)
                            Text(store.repo.language ?? "")
                                .font(.caption)
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(16)
            .navigationTitle(Text(store.repo.name))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
