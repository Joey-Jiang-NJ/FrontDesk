//
//  Rotation.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import Foundation
import SwiftData

class Rotation: ObservableObject {
    /*
    Relationships:
    Many-to-One: Trainee
     */
    var rotationID: String = ""
    var rotationName: String = ""
    var facultyName: String = ""
    var startDate: String = ""
    var end_date: String = ""
}
