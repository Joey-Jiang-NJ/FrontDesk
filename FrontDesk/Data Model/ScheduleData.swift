//
//  ScheduleData.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/25/24.
//

import Foundation

class ScheduleData: ObservableObject {
    static var data: ScheduleData = ScheduleData(mode: 1)
    
    @Published var traineeList: [Trainee]
    @Published var caseList: [Case]
    @Published var facultyList: [Faculty]
    init(mode: Int) {
        if mode == 0{ // use default data
            self.traineeList = Trainee.defaultTrainees
            self.caseList = Case.defaultCases
            self.facultyList = Faculty.defaultFaculties
        } else { // use database data
            self.traineeList = []
            self.caseList = []
            self.facultyList = []
        }
    }
    
    init (traineeList: [Trainee], caseList: [Case], facultyList: [Faculty]) {
        self.traineeList = traineeList
        self.caseList = caseList
        self.facultyList = facultyList
    }
}
