//
//  DataModel.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/6/24.
//

import Foundation


class Faculty: ObservableObject {
    @Published var preferences: FacultyPreference
    
    init(preferences: FacultyPreference) {
        self.preferences = preferences
    }
    
    
}


// example class for FacultyPreference
class FacultyPreference: ObservableObject {
    var Preop_Communication: PreoperativeCommunication
    var Preop_Assessment: PreopAssessment
    
    init(Preop_Communication: PreoperativeCommunication, Preop_Assessment: PreopAssessment) {
        self.Preop_Communication = Preop_Communication
        self.Preop_Assessment = Preop_Assessment
    }
}

struct PreferenceOption {
    let title: String
    let options: [String]
}

