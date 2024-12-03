//
//  Item.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/5.
//

import Foundation
import SwiftData

struct CaseLog: Identifiable {
    var id = UUID()
    var title: String
    var date: Date
    var description: String
    static var defaultCaseLogs: [CaseLog] = [
        CaseLog(title: "Case 1", date: Date(), description: "A 45-year-old male patient underwent laparoscopic cholecystectomy for gallstone disease. The surgery was uneventful; however, within 24 hours postoperatively, the patient developed afever and abdominal pain. A CT scan revealed a small bile leak at the surgical site.The patient was managed with percutaneous drainage and antibiotics. This case highlightsthe importance of postoperative monitoring and timely intervention."),
        CaseLog(title: "Case 2", date: Date() - 119878, description: "A 32-year-old female presented to the labor and delivery unit at 39 weeks of gestationwith spontaneous rupture of membranes. During delivery, fetal heart rate decelerationswere noted, requiring an emergency cesarean section. A healthy 7-pound baby girl was delivered.The mother experienced mild hemorrhage, which was controlled with uterotonics.This case underscores the importance of rapid decision-making in obstetrics."),
        CaseLog(title: "Case 3", date: Date() - 993284, description: "A 60-year-old male presented to the emergency department with chest pain, radiating to the left arm, accompanied by shortness of breath and diaphoresis. ECG showed ST-segment elevation in the anterior leads, indicating an acute anterior myocardial infarction.The patient was taken emergently to the cath lab, where a stent was placed in the LAD artery.He was started on dual antiplatelet therapy and discharged in stable condition.")
    ]
}

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
    var isAvailableForCase: Bool = true
    var relatedFaculties: [Faculty] = []
    var evalCount: Int = 0
    var evalScore: Double = 0
    @Published var caseID: String = ""
    
    @Published var caseLogs: [CaseLog] = []
    // var case_logs: [CaseLog]
    // var Self_reflection: [SelfReflection]
    // var faculty evaluations: [Evaluation]
    
    static let defaultTrainee = Trainee(
        traineeID: "076eee0e-04bf-413a-8dc1-5a52ed8ee7b7",
        rotationID: "54321",
        firstName: "David",
        lastName: "Doe",
        emailAddress: "john.doe@duke.edu",
        relatedFaculties: [],
        caseLogs: CaseLog.defaultCaseLogs
    )
    
    static let defaultTrainees: [Trainee] = [
        Trainee(
            traineeID: "12345",
            rotationID: "54321",
            firstName: "John",
            lastName: "Doe",
            emailAddress: "john.doe@duke.edu",
            relatedFaculties: Faculty.defaultFaculties,
            caseLogs: CaseLog.defaultCaseLogs
        ),
        Trainee(
            traineeID: "23452",
            rotationID: "54321",
            firstName: "wfojwio",
            lastName: "woeifj",
            emailAddress: "jane.doe@duke.edu",
            relatedFaculties: Faculty.defaultFaculties,
            caseLogs: CaseLog.defaultCaseLogs
            
        ),
        Trainee(
            traineeID: "13141",
            rotationID: "54321",
            firstName: "woipjf",
            lastName: "eijvwie",
            emailAddress: "john.doe@duke.edu",
            relatedFaculties: Faculty.defaultFaculties,
            caseLogs: CaseLog.defaultCaseLogs
        )
    ]
    
        init(){}
    
        init(
            traineeID: String,
            rotationID: String,
            firstName: String,
            lastName: String,
            emailAddress: String,
            relatedFaculties: [Faculty],
            caseLogs: [CaseLog]
        ){
            self.traineeID = traineeID
            self.rotationID = rotationID
            self.firstName = firstName
            self.lastName = lastName
            self.emailAddress = emailAddress
            self.relatedFaculties = relatedFaculties
            self.caseLogs = caseLogs
        }
    }
