//
//  SearchBar.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 3.03.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let color = Color(hue: 0.6, saturation: 0, brightness: 0.95)
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.sentences)
                .padding(8) .padding(.horizontal, 24)
                .background(color)
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
        }
        .padding(.horizontal, 4)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
