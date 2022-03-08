//
//  CustomInputField.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 27.02.2022.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
            }
            Divider()
                .background(.gray)
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholder: "hello", text: .constant(""))
    }
}
