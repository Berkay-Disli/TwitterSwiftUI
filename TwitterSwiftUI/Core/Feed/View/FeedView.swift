//
//  FeedView.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 24.02.2022.
//

import SwiftUI

struct FeedView: View {
    @State private var showNewTweetView = false
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
             ScrollView {
                LazyVStack {
                    ForEach(viewModel.tweets) { tweet in
                        TweetRowView(tweet: tweet)
                            
                    }
                }
            }
            Button {
                showNewTweetView.toggle()
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding()
            }
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .fullScreenCover(isPresented: $showNewTweetView) {
                NewTweetView()
            }

        }
        .navigationBarTitleDisplayMode(.inline )
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
