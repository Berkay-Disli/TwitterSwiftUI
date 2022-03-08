//
//  ImageUploader.swift
//  TwitterSwiftUI
//
//  Created by Berkay Disli on 28.02.2022.
//

import Foundation
import SwiftUI
import Firebase

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let fileName = UUID().uuidString
            let mediaRef = Storage.storage().reference().child("ProfilePhotos")
            let imageRef = mediaRef.child("\(fileName).jpg")
            
            imageRef.putData(imageData, metadata: nil) { metadata, error in
                if error == nil {
                    imageRef.downloadURL { imageURL, error in
                        if error == nil {
                            if let imageUrl = imageURL?.absoluteString {
                                completion(imageUrl)
                            }
                        }
                    }
                }
            }
        }
    }
}
