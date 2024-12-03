//
//  ScheduleData.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/25/24.
//

import Foundation

class ScheduleData: ObservableObject {
    @Published var traineeList: [Trainee]
    @Published var caseList: [Case]
    @Published var faclutyList: [Faculty]
    init() {
        self.traineeList = Trainee.defaultTrainees
        self.caseList = Case.defaultCases
        self.faclutyList = Faculty.defaultFaculties
    }
    
    init (traineeList: [Trainee], caseList: [Case], facultyList: [Faculty]) {
        self.traineeList = traineeList
        self.caseList = caseList
        self.faclutyList = facultyList
    }
}
