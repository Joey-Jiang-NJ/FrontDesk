//
//  CaseInfo.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct CaseInfoView: View {
    @EnvironmentObject var trainee: Trainee
    @ObservedObject var curCase: Case

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // header
                    Text("Case Information")
                    // we edit the font style here
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    // change the color of the area of the case information
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.black]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.2), radius: 5)

                    // Basic Info Section
                    SectionHeader(title: "Basic Info")
                    VStack(alignment: .leading, spacing: 15) {
                        // assign different information to differnet label
                        InfoRow(label: "Case ID:", value: curCase.id)
                        InfoRow(label: "Case Type:", value: curCase.type)
                        InfoRow(label: "Patient Information:", value: curCase.patientInfo)
                        InfoRow(label: "Symptoms:", value: curCase.symptoms)
                        InfoRow(label: "Diagnosis:", value: curCase.diagnosis)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)

                    // Faculties Section
                    SectionHeader(title: "Faculties")
                    VStack(spacing: 15) {
                        ForEach(trainee.relatedFaculties) { faculty in
                            NavigationLink(destination: FacultyPreferenceView(faculty: faculty)) {
                                HStack {
                                    Text("\(faculty.fName) \(faculty.lName)")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white.opacity(0.9))
                                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                                )
                            }
                         
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
}

struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.orange)
            .padding(.horizontal)
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.primary)
                
            
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
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
