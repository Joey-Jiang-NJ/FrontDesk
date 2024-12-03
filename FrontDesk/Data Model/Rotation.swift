//
//  Rotation.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import Foundation
import SwiftData

class Rotation: ObservableObject, Identifiable {
    /*
    Relationships:
    Many-to-One: Trainee
     */
    var id: String = ""
    var rotationName: String = ""
    var facultyName: String = ""
    var startDate: String = ""
    var endDate: String = ""
    
    static let defaultCurRotation = Rotation(
        id: "1",
        rotationName: "Gynecologic Oncology",
        facultyName: "Anthony Sullivan",
        startDate: "07/19/2019",
        endDate: "08/19/2019")
    
    static let defaultPastRotations = [
        Rotation(
            id: "2",
            rotationName: "Labor and Delivery",
            facultyName: "Anthony Sullivan",
            startDate: "07/19/2019",
            endDate: "08/19/2019"),
        Rotation(
            id: "3",
            rotationName: "Obstetrics",
            facultyName: "Anthony Sullivan",
            startDate: "07/19/2019",
            endDate: "08/19/2019"),
        Rotation(
           id: "3",
           rotationName: "Pediatrics",
           facultyName: "Anthony Sullivan",
           startDate: "07/19/2019",
           endDate: "08/19/2019"),
        Rotation(
            id: "5",
            rotationName: "Cardiology",
            facultyName: "Anthony Sullivan",
            startDate: "07/19/2019",
            endDate: "08/19/2019")
    ]
    
    init(){}
    init(id: String, rotationName: String, facultyName: String, startDate: String, endDate: String){
        self.id = id
        self.rotationName = rotationName
        self.facultyName = facultyName
        self.startDate = startDate
        self.endDate = endDate
    }
}
