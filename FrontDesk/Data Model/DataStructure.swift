//
//  DataStructure.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation

enum Gender : String, Codable, CaseIterable {
    case Unknown = "Unknown" // has not been specified
    case Male = "Male"
    case Female = "Female"
    case Other = "Other" // has been specified, but is not “Male” or “Female”
}

// preferences
enum PreoperativeCommunication : String, Codable, CaseIterable {
    case phoneCall = "Phone Call"
    case text = "Text"
}

enum PreopAssessment : String, Codable, CaseIterable {
    case  comprehensivePresentation = "comprehensive presentation"
    case pertinentPosAndNegOnly = "pertinent positives and negatives only"
}
