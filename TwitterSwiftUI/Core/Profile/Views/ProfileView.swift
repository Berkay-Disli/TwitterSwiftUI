//
//  ProfileView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 24.02.2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var selectedFilter: TweetFilterViewModel = .tweets
    @Environment(\.dismiss) var dismiss     //instead of presentationmode
    @Namespace var animation
    
    
    init(user: User) {
        self.viewModel = ProfileViewModel(userr: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            actionButtons
            userInfoDetails
            tweetFilterBar
            tweetsView
            
            
            Spacer()
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(id: UUID().uuidString, username: "dummyuser", email: "dummy@gmail.com", fullname: "mr. dummy", profileImageUrl: ""))
    }
}

extension ProfileView {
    var headerView: some View {
        ZStack(alignment: .bottomLeading) {
            Color.orange
                .ignoresSafeArea()
            VStack {
                Button {
                    dismiss()   // instead of .wrappedvalue.dismiss()
                } label: {
                    HStack(alignment: .bottom) {
                        Text("")
                        Image(systemName: "arrow.left")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 25, height: 20)
                            .fixedSize(horizontal: true, vertical: true)
                        .foregroundColor(.white)
                    }
                        

                }

                KFImage(URL(string: viewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 72, height: 72)
                    .offset(x: 16, y: 24)
            }
        }
        .frame(height: 96)
        
    }
    
    var actionButtons: some View {
        HStack(spacing: 12){
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
            Button {
                //
            } label: {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .frame(width: 120, height: 32)
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
                    
            }

        }
        .padding(.trailing)
    }
    
    var userInfoDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(viewModel.user.fullname)
                    .font(.title2).bold()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(.blue)
            }
            Text("@\(viewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("The loving father of this app")
                .font(.subheadline)
                .padding(.vertical)
            HStack(spacing: 24) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                    Text("İstanbul, TR")

                }
                
                HStack {
                    Image(systemName: "link")
                    Text("www.berkaydisli.com")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
            
            UserStatsView()
                .padding(.vertical)
            
        }
        .padding(.horizontal)
    }
    
    var tweetFilterBar: some View {
        HStack {
            ForEach(TweetFilterViewModel.allCases, id: \.self ) { item in
                VStack {
                    Text(item.Title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    if selectedFilter == item {
                        Capsule().fill(Color.orange)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    } else {
                        Capsule().fill(Color.clear)
                            .frame(height: 3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x: 0, y: 16))
    }
    
    var tweetsView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.tweets(forFilter: self.selectedFilter)) { tweet in
                    TweetRowView(tweet: tweet)
                }
            }
        }
    }
}
