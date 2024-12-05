//
//  Item.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/5.
//

import Foundation

class CaseLog: ObservableObject, Identifiable, Codable {
    var id = UUID()
    var title: String = ""
    var date: Date = Date()
    var description: String = ""
    var selfRef: SelfReflection = SelfReflection()
    
    static var defaultCaseLogs: [CaseLog] = [
        CaseLog(
            title: "Case 1",
            date: Date(),
            description: "A 45-year-old male patient underwent laparoscopic cholecystectomy for gallstone disease. The surgery was uneventful; however, within 24 hours postoperatively, the patient developed afever and abdominal pain. A CT scan revealed a small bile leak at the surgical site.The patient was managed with percutaneous drainage and antibiotics. This case highlightsthe importance of postoperative monitoring and timely intervention."
        ),
        CaseLog(
            title: "Case 2",
            date: Date() - 119878,
            description: "A 32-year-old female presented to the labor and delivery unit at 39 weeks of gestationwith spontaneous rupture of membranes. During delivery, fetal heart rate decelerationswere noted, requiring an emergency cesarean section. A healthy 7-pound baby girl was delivered.The mother experienced mild hemorrhage, which was controlled with uterotonics.This case underscores the importance of rapid decision-making in obstetrics."
        ),
        CaseLog(
            title: "Case 3",
            date: Date() - 993284,
            description: "A 60-year-old male presented to the emergency department with chest pain, radiating to the left arm, accompanied by shortness of breath and diaphoresis. ECG showed ST-segment elevation in the anterior leads, indicating an acute anterior myocardial infarction.The patient was taken emergently to the cath lab, where a stent was placed in the LAD artery.He was started on dual antiplatelet therapy and discharged in stable condition."
        )
    ]
    
    init(){}
    
    init(title: String, date: Date, description: String){
        self.title = title
        self.date = date
        self.description = description
    }
}

class Trainee: ObservableObject {
    /*
     Relationships:
     One-to-Many : CaseLog
     Many-to-Many: Faculty
     */
    @Published var traineeID: String = "" // primary key
    @Published var rotationID: String = "" // foreign key
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var emailAddress: String = ""
    @Published var picture: String = ""
    @Published var isAvailableForCase: Bool = true
    @Published var relatedFaculties: [Faculty] = []
    @Published var evalCount: Int = 0
    @Published var evalScore: Double = 0
    @Published var caseID: String = ""
    
    @Published var caseLogs: [CaseLog] = []
    
//    @Published var selfRef: SelfReflection = SelfReflection()
    // var case_logs: [CaseLog]
    // var Self_reflection: [SelfReflection]
    // var faculty evaluations: [Evaluation]
    
    static var activeTrainee: Trainee = Trainee()
    
    static let defaultTrainee: Trainee = Trainee(
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
    
    let archiveName: String = "sf"
    let archiveName2: String = "cl"
    
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
    
    func getURL(_ fileName: String) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

    
//    func save(url: URL) -> Bool {
//        var outputData = Data()
//        if let encoded = try? encoder.encode(self.selfRef) {
//            outputData = encoded
//            do {
//                try outputData.write(to: getURL(archiveName))
//            } catch let error as NSError {
//                print (error)
//                return false
//            }
//            return true
//        }
//        else { return false }
//    }
//
//    func saveToArch() -> Bool{
//        return self.save(url: self.getURL(self.archiveName))
//    }
//
//    func load(url: URL) -> Bool {
//        var loaded = SelfReflection()
//        var tempData = Data()
//        do {
//            tempData = try Data(contentsOf: getURL(archiveName))
//        } catch let error as NSError {
//            print(error)
//            return false
//        }
//        if tempData.isEmpty {
//            return false
//        }
//        if let decoded = try? decoder.decode(SelfReflection.self, from: tempData) {
//            loaded = decoded
//            self.selfRef = loaded
//            return true
//        }else { return false }
//    }
//
//    func loadFromArch() -> Bool{
//        return self.load(url: self.getURL(self.archiveName))
//    }
    
    
    func saveCL(url: URL) -> Bool {
        var outputData = Data()
        if let encoded = try? encoder.encode(self.caseLogs) {
            outputData = encoded
            do {
                try outputData.write(to: getURL(archiveName2))
            } catch let error as NSError {
                print (error)
                return false
            }
            return true
        }
        else { return false }
    }

    func saveToArchCL() -> Bool{
        return self.saveCL(url: self.getURL(self.archiveName2))
    }

    func loadCL(url: URL) -> Bool {
        var loaded = [CaseLog]()
        var tempData = Data()
        do {
            tempData = try Data(contentsOf: getURL(archiveName2))
        } catch let error as NSError {
            print(error)
            return false
        }
        if tempData.isEmpty {
            return false
        }
        print(tempData)
        if let decoded = try? decoder.decode([CaseLog].self, from: tempData) {
            loaded = decoded
            self.caseLogs = loaded
            return true
        }else { return false }
    }

    func loadFromArchCL() -> Bool{
        return self.loadCL(url: self.getURL(self.archiveName2))
    }
}
