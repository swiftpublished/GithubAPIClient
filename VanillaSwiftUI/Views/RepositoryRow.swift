//
//  RepositoryRow.swift
//  VanillaSwiftUI
//
//  Created by Muralidharan Kathiresan on 01/10/23.
//

struct RepositoryRow: View {
    @Binding var repo: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: repo.owner.avatarURL)) { image in
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
                
                Text(repo.name)
                    .font(.headline)
                
                Spacer()
                
                Button {
                    repo.isStarred.toggle()
                } label: {
                    Image(systemName: repo.isStarred ? "heart.fill" : "heart")
                        .foregroundColor(.yellow)
                }
                .buttonStyle(.plain)
            }
            
            repo.description.map(Text.init(_:))
                .lineLimit(2)
        }
    }
}
