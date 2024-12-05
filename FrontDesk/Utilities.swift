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

func copyTrainee(from t1: Trainee, to t2: Trainee) {
    t2.traineeID = t1.traineeID
    t2.firstName = t1.firstName
    t2.lastName = t1.lastName
    t2.caseID = t1.caseID
    t2.picture = t1.picture
    t2.emailAddress = t1.emailAddress
    t2.isAvailableForCase = t1.isAvailableForCase
    t2.relatedFaculties = t1.relatedFaculties
    t2.rotationID = t1.rotationID
    t2.evalCount = t1.evalCount
    t2.evalScore = t1.evalScore
}

func copyFaculty(from f1: Faculty, to f2: Faculty) {
    f2.id = f1.id
    f2.fName = f1.fName
    f2.lName = f1.lName
    f2.caseID = f1.caseID
    f2.relatedTrainees = f1.relatedTrainees
    f2.email = f1.email
    f2.preferences = f1.preferences
}

func copyCase(from c1: Case, to c2: Case) {
    c2.id = c1.id
    c2.trainees = c1.trainees
    c2.faculties = c1.faculties
    c2.traineeList = c1.traineeList
    c2.facultyList = c1.facultyList
    c2.patientInfo = c1.patientInfo
    c2.type = c1.type
    c2.symptoms = c1.symptoms
    c2.diagnosis = c1.diagnosis
}


