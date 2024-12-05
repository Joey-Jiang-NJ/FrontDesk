//
//  CaseInfo.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct CaseView: View {
    @EnvironmentObject var data: ScheduleData
    @ObservedObject var curCase: Case
    
    var faculties: [Faculty] {
        data.facultyList.filter{curCase.faculties.contains($0.id)}
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Case Information")
                .font(.system(size: 25, weight: .bold, design: .default))
                .padding()
            List{
                // first show the information of the current case
                HStack{
                    Text("Case ID:").fontWeight(.bold)
                    Text(curCase.id)
                }
                
                HStack{
                    Text("Case Type:").fontWeight(.bold)
                    Text(curCase.type)
                }
                VStack(alignment: .leading){
                    Text("Patient Information:").fontWeight(.bold)
                    Text(curCase.patientInfo)
                }
                VStack(alignment: .leading){
                    Text("Symptoms:").fontWeight(.bold)
                    Text(curCase.symptoms)
                }
                VStack(alignment: .leading){
                    Text("Diagnosis:").fontWeight(.bold)
                    Text(curCase.diagnosis)
                }
                
                // the second section show the information of the faculty
//                Section(header: Text("Faculties").textCase(nil).font(.system(size: 28, weight:.bold, design: .default)).foregroundStyle(Color.orange)){
//                    ForEach(faculties) { faculty in
//                        NavigationLink{
//                            FacultyPreferenceView(faculty: faculty)
//                        } label: {
//                            Text("\(faculty.fName) \(faculty.lName)")
//                        }
//                    }
//                }
            }
            
        }
    }
}

//#Preview {
//    let faculty1 = Faculty(
//        id: "1",
//        fName: "Abigail",
//        lName: "Cruise",
//        preferences: ["Preoperative communication":"Ensure the patient and family are well-informed of the procedure, risks, and recovery expectations. ",
//                      "Preop assessment":"Complete a thorough history and physical exam, focusing on cardiovascular and respiratory status.",
//                      "Preop orders": "NPO after midnight, standard IV access with 18-gauge catheter. Request type and screen in case of blood loss.",
//                      "Premedication": "Administer midazolam 2 mg IV for anxiety in the preop area, unless contraindicated.",
//                      "Maintenance": "Use balanced anesthesia (e.g., propofol induction, sevoflurane for maintenance). Monitor closely for hemodynamic stability.",
//                      "Pain Management": "Start with IV acetaminophen intraoperatively, add fentanyl for breakthrough pain. Plan for multimodal pain management postoperatively.",
//                      "Fluid Management": "Start with 1-2 L of Lactated Ringer’s, adjusting for blood loss and urine output.",
//                      "Postoperative Orders": "Continue IV fluids until oral intake is sufficient. Monitor vital signs every 4 hours, encourage ambulation, and start prophylactic antibiotics if indicated."
//                     ])
//
//    let faculty2 = Faculty(
//        id: "2",
//        fName: "Anthony",
//        lName: "Sullivan",
//        preferences: ["Preoperative communication":"Emphasize the need for family presence and support due to the invasive nature of the procedure. Discuss ICU stay and potential postoperative complications.",
//                      "Preop assessment":"Obtain comprehensive cardiac workup (echocardiogram, cardiac enzymes, stress test if indicated). Ensure clearance from a cardiologist.",
//                      "Preop orders": "NPO after midnight, insert two large-bore IVs, and type and cross for 2 units of PRBCs.",
//                      "Premedication": "Administer metoprolol if hypertensive and midazolam 1 mg IV for relaxation.",
//                      "Maintenance": "Use high-dose opioid anesthesia (e.g., fentanyl) with isoflurane for minimal cardiovascular depression. Monitor invasive lines (A-line, CVP).",
//                      "Pain Management": "Plan for epidural anesthesia if feasible. IV opioids (morphine) are standard for postoperative pain control.",
//                      "Fluid Management": "Avoid fluid overload; use diuretics if necessary. Maintain adequate perfusion with crystalloids and blood products as needed.",
//                      "Postoperative Orders": "Initiate ICU monitoring with close cardiac output and fluid balance assessment. Consider extubation readiness in 12-24 hours."
//                     ])
//    let faculties = [faculty1, faculty2]
//
//    let curCase = Case(
//        id: "MC-2023-0457",
//        type: "Cardiology",
//        patientInfo: "J.D., 52, Male, Caucasian, Smoker (1 pack/day for 20 years), occasional alcohol use",
//        symptoms: "Severe chest pain radiating to the left arm",
//        diagnosis: "Acute Myocardial Infarction (Heart Attack)",
//        faculties: faculties
//    )
//
//    CaseInfoView(curCase: curCase)
//}
