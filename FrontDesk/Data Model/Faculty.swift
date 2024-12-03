//
//  Faculty.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/7.
//

import Foundation
import SwiftData

class Faculty: ObservableObject, Identifiable {
    @Published var id: String = ""
    @Published var fName: String = ""
    @Published var lName: String = ""
    @Published var preferences: [String: String] = [:]
    @Published var relatedTrainees: [Trainee] = []
    @Published var caseID: String = ""
    
    static let defaultFaculty = Faculty(
        id: "367bdd45-aaf4-443a-8e54-5920cf3d169c",
        fName: "Dr. Emily",
        lName: "Clark",
        preferences: [:],
        relatedTrainees: [],
        caseID: "ba99677d-c1dd-42e4-a702-e9dc04708fa0"
    )
    
    static let defaultFaculties = [
        Faculty(
            id: "1",
            fName: "Abigail",
            lName: "Cruise",
            preferences: ["Preoperative communication":"Ensure the patient and family are well-informed of the procedure, risks, and recovery expectations. ",
                          "Preop assessment":"Complete a thorough history and physical exam, focusing on cardiovascular and respiratory status.",
                          "Preop orders": "NPO after midnight, standard IV access with 18-gauge catheter. Request type and screen in case of blood loss.",
                          "Premedication": "Administer midazolam 2 mg IV for anxiety in the preop area, unless contraindicated.",
                          "Maintenance": "Use balanced anesthesia (e.g., propofol induction, sevoflurane for maintenance). Monitor closely for hemodynamic stability.",
                          "Pain Management": "Start with IV acetaminophen intraoperatively, add fentanyl for breakthrough pain. Plan for multimodal pain management postoperatively.",
                          "Fluid Management": "Start with 1-2 L of Lactated Ringer’s, adjusting for blood loss and urine output.",
                          "Postoperative Orders": "Continue IV fluids until oral intake is sufficient. Monitor vital signs every 4 hours, encourage ambulation, and start prophylactic antibiotics if indicated."
                         ],
            relatedTrainees: [],
            caseID: ""
        ),
        Faculty(
            id: "2",
            fName: "Anthony",
            lName: "Sullivan",
            preferences: ["Preoperative communication":"Emphasize the need for family presence and support due to the invasive nature of the procedure. Discuss ICU stay and potential postoperative complications.",
                          "Preop assessment":"Obtain comprehensive cardiac workup (echocardiogram, cardiac enzymes, stress test if indicated). Ensure clearance from a cardiologist.",
                          "Preop orders": "NPO after midnight, insert two large-bore IVs, and type and cross for 2 units of PRBCs.",
                          "Premedication": "Administer metoprolol if hypertensive and midazolam 1 mg IV for relaxation.",
                          "Maintenance": "Use high-dose opioid anesthesia (e.g., fentanyl) with isoflurane for minimal cardiovascular depression. Monitor invasive lines (A-line, CVP).",
                          "Pain Management": "Plan for epidural anesthesia if feasible. IV opioids (morphine) are standard for postoperative pain control.",
                          "Fluid Management": "Avoid fluid overload; use diuretics if necessary. Maintain adequate perfusion with crystalloids and blood products as needed.",
                          "Postoperative Orders": "Initiate ICU monitoring with close cardiac output and fluid balance assessment. Consider extubation readiness in 12-24 hours."
                         ],
            relatedTrainees: [],
            caseID: ""
        ),
    ]
    
    init(){}
    
    init(
        id: String,
        fName: String,
        lName: String,
        preferences: [String: String],
        relatedTrainees: [Trainee],
        caseID: String
    ){
        self.id = id
        self.fName = fName
        self.lName = lName
        self.preferences = preferences
        self.relatedTrainees = relatedTrainees
        self.caseID = caseID
    }
}
