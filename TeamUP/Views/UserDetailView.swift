import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            Image(user.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding(.top, 20)
            
            Text(user.name)
                .font(.system(size: 28, weight: .bold))
                .padding(.top, 10)
            
            Text("\(user.age) años • \(user.gender)")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            Text(user.description)
                .font(.system(size: 16))
                .padding(.top, 10)
                .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(user.games, id: \.0) { game in
                    HStack {
                        Text(game.0)
                            .font(.system(size: 14, weight: .medium))
                        Text("•")
                            .foregroundColor(.gray)
                        Text(game.1)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .navigationBarTitle("Detalles del Usuario", displayMode: .inline)
    }
}
