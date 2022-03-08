//
//  AuthenticationHeader.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 27.02.2022.
//

import SwiftUI

struct AuthenticationHeader: View {
    let title1: String
    let title2: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 260)
        .padding(.leading)
        .background(color)
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

struct AuthenticationHeader_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeader(title1: "Berkay", title2: "Dişli", color: .orange)
    }
}
