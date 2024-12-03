//
//  FacultyPreference.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct FacultyPreferenceView: View {
    var faculty: Faculty

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            Text("\(faculty.fName) \(faculty.lName)'s Preferences")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)

            // List of Preferences
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    //This part is from gpt
                    ForEach(
                        faculty.preferences.sorted(by: <),
                        id: \.key
                    ) {
                        key,
                        value in
                        VStack(alignment: .leading, spacing: 5) {
                            // Key (Title)
                            HStack {
                                Image(
                                    systemName: iconForPreference(key: key)
                                ) // Icon based on key
                                .font(.title2)
                                .foregroundColor(.blue)
                                Text(key)
                                    .font(
                                        .system(
                                            size: 18,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundColor(.primary)
                            }

                            // Value (Description)
                            Text(value)
                                .font(
                                    .system(
                                        size: 16,
                                        weight: .regular,
                                        design: .default
                                    )
                                )
                                .foregroundColor(.secondary)
                                .padding(.top, 2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(
                                    color: .gray.opacity(0.2),
                                    radius: 5,
                                    x: 0,
                                    y: 2
                                )
                        )
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all))
        }
        .padding()
    }

    // Function to determine icon based on preference key
    private func iconForPreference(key: String) -> String {
        switch key.lowercased() {
        case "preoperative communication": return "message.fill"
        case "preop assessment": return "stethoscope.circle.fill"
        case "preop orders": return "doc.text.fill"
        case "premedication": return "pills.fill"
        case "maintenance": return "gearshape.fill"
        case "pain management": return "bandage.fill"
        case "fluid management": return "drop.fill"
        case "postoperative orders": return "checklist"
        default: return "list.bullet"
        }
    }
}

//#Preview {
//    let faculty1 = Faculty(
//        id: "1",
//        fName: "Abigail",
//        lName: "Cruise",
//        preferences: [
//            "Preoperative communication": "Ensure the patient and family are well-informed of the procedure, risks, and recovery expectations.",
//            "Preop assessment": "Complete a thorough history and physical exam, focusing on cardiovascular and respiratory status.",
//            "Preop orders": "NPO after midnight, standard IV access with 18-gauge catheter. Request type and screen in case of blood loss.",
//            "Premedication": "Administer midazolam 2 mg IV for anxiety in the preop area, unless contraindicated.",
//            "Maintenance": "Use balanced anesthesia (e.g., propofol induction, sevoflurane for maintenance). Monitor closely for hemodynamic stability.",
//            "Pain Management": "Start with IV acetaminophen intraoperatively, add fentanyl for breakthrough pain. Plan for multimodal pain management postoperatively.",
//            "Fluid Management": "Start with 1-2 L of Lactated Ringer’s, adjusting for blood loss and urine output.",
//            "Postoperative Orders": "Continue IV fluids until oral intake is sufficient. Monitor vital signs every 4 hours, encourage ambulation, and start prophylactic antibiotics if indicated."
//        ]
//    )
//    FacultyPreferenceView(faculty: faculty1)
//}
