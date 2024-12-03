//
//  CaselogView.swift
//  FrontDesk
//
//  Created by DJY on 11/5/24.
//

import SwiftUI
import SwiftData

//struct CaseLogListView: View {
//    @EnvironmentObject var trainee: Trainee
////    let caseLogs = [
////        CaseLog(title: "Case 1", date: Date(), description: "A 45-year-old male patient underwent laparoscopic cholecystectomy for gallstone disease. The surgery was uneventful; however, within 24 hours postoperatively, the patient developed afever and abdominal pain. A CT scan revealed a small bile leak at the surgical site.The patient was managed with percutaneous drainage and antibiotics. This case highlightsthe importance of postoperative monitoring and timely intervention."),
////        CaseLog(title: "Case 2", date: Date() - 119878, description: "A 32-year-old female presented to the labor and delivery unit at 39 weeks of gestationwith spontaneous rupture of membranes. During delivery, fetal heart rate decelerationswere noted, requiring an emergency cesarean section. A healthy 7-pound baby girl was delivered.The mother experienced mild hemorrhage, which was controlled with uterotonics.This case underscores the importance of rapid decision-making in obstetrics."),
////        CaseLog(title: "Case 3", date: Date() - 993284, description: "A 60-year-old male presented to the emergency department with chest pain, radiating to the left arm, accompanied by shortness of breath and diaphoresis. ECG showed ST-segment elevation in the anterior leads, indicating an acute anterior myocardial infarction.The patient was taken emergently to the cath lab, where a stent was placed in the LAD artery.He was started on dual antiplatelet therapy and discharged in stable condition.")
////    ]
//    var body: some View {
//        NavigationView {
//            ZStack {
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.green.opacity(0.2)]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .ignoresSafeArea()
//
//                List(trainee.caseLogs) { caseLog in
//                    NavigationLink(destination: CaseDetailView(caseLog: caseLog)) {
//                        HStack {
//                            Image(systemName: "folder.fill")
//                                .font(.largeTitle)
//                                .foregroundColor(.blue)
//
//                            VStack(alignment: .leading) {
//                                Text(caseLog.title)
//                                    .font(.headline)
//                                Text(caseLog.date, style: .date)
//                                    .font(.subheadline)
//                                    .foregroundColor(.secondary)
//                            }
//                        }
//                        .padding()
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.gray.opacity(0.1))
//                        )
//                    }
//                }
//                .scrollContentBackground(.hidden)
//                .listStyle(InsetGroupedListStyle())
//            }
//            .navigationTitle("Case Logs")
//        }
//    }
//}

import SwiftUI

struct CaseLogListView: View {
    @EnvironmentObject var trainee: Trainee
    @State private var showSheet = false
    @State private var newCaseLog = CaseLog(
        title: "",
        date: Date(),
        description: ""
    )

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.blue.opacity(0.2),
                            Color.green.opacity(0.2)
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    List{
                        ForEach(trainee.caseLogs, id: \.id){ caseLog in
                            NavigationLink(
                                destination: CaseDetailView(caseLog: caseLog)
                            ) {
                                HStack {
                                    Image(systemName: "folder.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    
                                    VStack(alignment: .leading) {
                                        Text(caseLog.title)
                                            .font(.headline)
                                        Text(caseLog.date, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.1))
                                )
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())

                    Button(
                        action: {
                            newCaseLog = CaseLog(
                                title: "",
                                date: Date(),
                                description: ""
                            )
                            showSheet = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                Text("New Case Log")
                                    .font(.headline)
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .padding()
                }
            }
            .navigationTitle("Case Logs")
            .sheet(isPresented: $showSheet) {
                EditCaseLogView(caseLog: $newCaseLog) {
                    print(trainee.caseLogs)
                    trainee.caseLogs.append(newCaseLog)
                    print(trainee.caseLogs)
                    showSheet = false
                } onCancel: {
                    showSheet = false
                }
            }
        }
    }
}

struct EditCaseLogView: View {
    @Binding var caseLog: CaseLog
    @EnvironmentObject var trainee: Trainee
    
    var onSave: () -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Case Title")) {
                    TextField("Enter case title", text: $caseLog.title)
                }
                Section(header: Text("Case Date")) {
                    DatePicker(
                        "Enter case date",
                        selection: $caseLog.date,
                        displayedComponents: .date
                    )
                }
                Section(header: Text("Case Description")) {
                    TextEditor(text: $caseLog.description)
                        .frame(height: 150)
                }
            }
            .navigationTitle("Edit Case Log")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onCancel()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave()
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CaseLogListView()
}



struct CaseDetailView: View {
    @State private var isShowingProtocol = false
    @State private var showSheet = false
    @State var caseLog: CaseLog

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: [Color.blue.opacity(0.2), Color.white]
                ),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    Text(caseLog.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    // Date
                    Text(caseLog.date, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // Description
                    Text(caseLog.description)
                        .font(.body)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(
                                    color: Color.gray.opacity(0.3),
                                    radius: 10,
                                    x: 0,
                                    y: 5
                                )
                        )
                    
//                    Button(action: {
//                        showSheet = true
//                    }) {
//                        Text("Edit Log")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(
//                                LinearGradient(
//                                    gradient: Gradient(
//                                        colors: [Color.orange, Color.red]
//                                    ),
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .cornerRadius(15)
//                            .shadow(
//                                color: Color.orange.opacity(0.5),
//                                radius: 8,
//                                x: 0,
//                                y: 4
//                            )
//                    }
//                    .sheet(isPresented: $showSheet) {
//                        EditCaseLogView(caseLog: $caseLog) {
//                            showSheet = false
//                        } onCancel: {
//                            showSheet = false
//                        }
//                    }
                    
                    Spacer()
                    
                    // Self-reflection Button
                    Button(action: {
                        isShowingProtocol = true
                    }) {
                        Text("Self Reflection")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [Color.orange, Color.red]
                                    ),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(
                                color: Color.orange.opacity(0.5),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                    }
                    .sheet(isPresented: $isShowingProtocol) {
                        SelfReflectionView()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Case Details")
    }
}


#Preview {
    CaseLogListView()
}

