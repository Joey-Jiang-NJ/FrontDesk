//
//  Case.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/7.
//

import Foundation

class Case: ObservableObject, Identifiable {
    @Published var id: String = ""
    @Published var type: String = ""
    @Published var patientInfo: String = ""
    @Published var symptoms: String = ""
    @Published var diagnosis: String = ""
    @Published var trainees: [String] = []
    @Published var faculties: [String] = []
    @Published var facultyList: [Faculty] = []
    @Published var traineeList: [Trainee] = []
    
    init(){}
    
    static var activeCase = Case()
    
    static var defaultCase =  Case(
        id: "###",
        type: "Cardiology",
        patientInfo: "J.D., 52, Male, Caucasian, Smoker (1 pack/day for 20 years), occasional alcohol use",
        symptoms: "Severe chest pain radiating to the left arm",
        diagnosis: "Acute Myocardial Infarction (Heart Attack)",
        trainees: [Trainee.defaultTrainee.traineeID],
        faculties: [Faculty.defaultFaculties[0].id]
    )
    
    static var defaultCases: [Case] = [
        Case(
            id: "MC-2023-0457",
            type: "Cardiology",
            patientInfo: "J.D., 52, Male, Caucasian, Smoker (1 pack/day for 20 years), occasional alcohol use",
            symptoms: "Severe chest pain radiating to the left arm",
            diagnosis: "Acute Myocardial Infarction (Heart Attack)",
            trainees: [],
            faculties: [Faculty.defaultFaculties[0].id]
        ),
        Case(
            id: "MC-2023-0458",
            type: "Cardiology",
            patientInfo: "J.D., 52, Male, Caucasian, Smoker (1 pack/day for 20 years), occasional alcohol use",
            symptoms: "Severe chest pain radiating to the left arm",
            diagnosis: "Acute Myocardial Infarction (Heart Attack)",
            trainees: [],
            faculties: [Faculty.defaultFaculties[0].id]
        ),
        Case(
            id: "MC-2023-0459",
            type: "Cardiology",
            patientInfo: "J.D., 52, Male, Caucasian, Smoker (1 pack/day for 20 years), occasional alcohol use",
            symptoms: "Severe chest pain radiating to the left arm",
            diagnosis: "Acute Myocardial Infarction (Heart Attack)",
            trainees: [],
            faculties: [Faculty.defaultFaculties[0].id]
        )
    ]
    
    init(
        id: String,
        type: String,
        patientInfo: String,
        symptoms: String,
        diagnosis: String,
        trainees: [String],
        faculties: [String]
    ){
        self.id = id
        self.type = type
        self.patientInfo = patientInfo
        self.symptoms = symptoms
        self.diagnosis = diagnosis
        self.trainees = trainees
        self.faculties = faculties
    }
}
