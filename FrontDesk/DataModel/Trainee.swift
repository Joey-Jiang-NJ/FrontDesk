//
//  Item.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/5.
//

import Foundation
import SwiftData

class Trainee: ObservableObject {
    /*
    Relationships:
    One-to-Many : CaseLog
    Many-to-Many: Faculty
    */
    var traineeID: String = "" // primary key
    var rotationID: String = "" // foreign key
    var firstName: String = ""
    var lastName: String = ""
    var emailAddress: String = ""
    var picture: String = ""
    // var case_logs: [CaseLog]
    // var Self_reflection: [SelfReflection]
    // var faculty evaluations: [Evaluation]
    
    init(){}
    
    init(traineeID: String, rotationID: String, firstName: String, lastName: String, emailAddress: String){
        self.traineeID = traineeID
        self.rotationID = rotationID
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
    }
}
