//
//  Utilities.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import Foundation
import UIKit
import SwiftUI

let avatar = UIImage(named: "Elaina")

func imageFromString(_ strPic: String) -> UIImage {
    var picImage: UIImage?
    if let picImageData = Data(base64Encoded: strPic, options: .ignoreUnknownCharacters) {
        picImage = UIImage(data: picImageData)
    } else {
        picImage = avatar
    }
    if picImage == nil {
        picImage = avatar
    }
    return picImage!
}

func stringFromImage(_ imagePic: UIImage) -> String {
//    let picImageData: Data = imagePic.jpegData(compressionQuality: 0.2)!
    if let picImageData: Data = imagePic.pngData() {
        let picBase64 = picImageData.base64EncodedString()
        return picBase64
    }
    return ""
}
