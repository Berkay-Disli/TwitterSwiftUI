//
//  SideMenuView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 25.02.2022.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        if let user = authViewModel.currentUser {
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading) {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 48, height: 48)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.headline)
                        Text("@\(user.username)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    UserStatsView()
                        .padding(.vertical)
                }
                .padding(.leading)
                ForEach(SideMenuViewModel.allCases, id:\.self) { model in
                    if model == .profile {
                        NavigationLink {
                            ProfileView(user: user)
                        } label: {
                            SideMenuRowView(viewModel: model)
                        }
                    } else if model == .logout {
                        Button {
                            authViewModel.signOut()
                        } label: {
                            SideMenuRowView(viewModel: model)
                        }

                    } else {
                        SideMenuRowView(viewModel: model)
                    }
                }
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}

