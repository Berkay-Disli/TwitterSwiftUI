//
//  deneme.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import SwiftUI

struct deneme: View {
    var body: some View {
        VStack {
            Image("berkaydisli")
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 180)
                .clipShape(Circle())
                .padding(.top, 44)
                
        }
    }
}

struct deneme_Previews: PreviewProvider {
    static var previews: some View {
        deneme()
    }
}
