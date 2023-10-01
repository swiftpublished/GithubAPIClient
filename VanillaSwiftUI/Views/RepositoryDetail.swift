//
//  RepositoryDetail.swift
//  VanillaSwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

struct RepositoryDetail: View {
    @Binding var repo: Repository
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: repo.owner.avatarURL)) { image in
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
                    
                    Text(repo.name)
                        .font(.callout)
                    
                    Spacer()
                    
                    Button {
                        repo.isStarred.toggle()
                    } label: {
                        Image(systemName: repo.isStarred ? "heart.fill" : "heart")
                            .foregroundColor(.yellow)
                    }
                }
                
                repo.description.map(Text.init(_:))
                
                HStack(spacing: 16) {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(repo.numberOfStars?.description ?? "")
                            .font(.caption)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.triangle.branch")
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text(repo.numberOfForks?.description ?? "")
                            .font(.caption)
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(repo.languageColor)
                        Text(repo.language ?? "")
                            .font(.caption)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .padding(16)
        .navigationTitle(Text(repo.name))
        .navigationBarTitleDisplayMode(.inline)
    }
}
