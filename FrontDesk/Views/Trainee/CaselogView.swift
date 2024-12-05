//
//  CaselogView.swift
//  FrontDesk
//
//  Created by DJY on 11/5/24.
//

import SwiftUI

struct CaseLogListView: View {
    @EnvironmentObject var trainee: Trainee
    @State private var showSheetAction = false
    @State private var newCaseLog = CaseLog(
        title: "",
        date: Date(),
        description: ""
    )

    var body: some View {
        NavigationView {
            // first, set the background of the page
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.blue.opacity(0.21),
                            Color.green.opacity(0.22)
                        ]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                // make the background filled with all the screen

                VStack {
                    List{
                        ForEach(trainee.caseLogs, id: \.id){ caseLog in
                            // for each case log, we enter different detail view according to case id
                            NavigationLink(
                                destination: CaseDetailView(caseLog: caseLog).environmentObject(trainee)
                            ) {
                                // Here is one area for the folder
                                HStack {
                                    // first add the image
                                    Image(systemName: "folder.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.blue)
                                    // then get the title and the date
                                    VStack(alignment: .leading) {
                                        Text(caseLog.title)
                                            .font(.headline)
                                        Text(caseLog.date, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                // use the gray background to make the information more obvious
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.1))
                                )
                            }
                        }
                    }
                    // hide the origianl list style to make the background also shown in the list area
                    .scrollContentBackground(.hidden)
                 
                    
                    // add the plus button for user to add case log
                    Button(
                        action: {
                            newCaseLog = CaseLog(
                                title: "",
                                date: Date(),
                                description: ""
                            )
                            showSheetAction = true
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
            .sheet(isPresented: $showSheetAction) {
                EditCaseLogView(caseLog: $newCaseLog) {
                    trainee.caseLogs.append(newCaseLog)
                    _ = trainee.saveToArchCL()
                    showSheetAction = false
                } Cancelaction: {
                    showSheetAction = false
                }
            }
        }
    }
}

struct EditCaseLogView: View {
    @Binding var caseLog: CaseLog
    @EnvironmentObject var trainee: Trainee
    
    // Here we use two func as variable
    var Saveaction: () -> Void
    var Cancelaction: () -> Void

    var body: some View {
        NavigationView {
            //MARK: we leanred Form from gpt
            Form {
                Section(header: Text("Case Title")) {
                    TextField("Enter case title", text: $caseLog.title)
                }
                Section(header: Text("Case Date")) {
                    // MARK: We ask chatgpt on how to use Date Picker
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
            // add the save and cancel button on the top of the page
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        Cancelaction()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Saveaction()
                        
                    }
                }
            }
        }
    }
}

//struct EditCaseLogView: View {
//    @Binding var caseLog: CaseLog
//    @EnvironmentObject var trainee: Trainee
//
//    var onSave: () -> Void
//    var onCancel: () -> Void
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 16) {
//                    Text("Case Title")
//                        .font(.headline)
//                    TextField("Enter case title", text: $caseLog.title)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    Text("Case Date")
//                        .font(.headline)
//                    DatePicker(
//                        "Enter case date",
//                        selection: $caseLog.date,
//                        displayedComponents: .date
//                    )
//                    .datePickerStyle(GraphicalDatePickerStyle())
//
//                    Text("Case Description")
//                        .font(.headline)
//                    TextEditor(text: $caseLog.description)
//                        .frame(height: 150)
//                        .border(Color.gray, width: 1)
//                        .cornerRadius(5)
//                }
//                .padding()
//            }
//            .navigationTitle("Edit Case Log")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        onCancel()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        onSave()
//                    }
//                }
//            }
//        }
//    }
//}


//#Preview {
//    CaseLogListView()
//}






struct CaseDetailView: View {
    @EnvironmentObject var trainee: Trainee
    @State private var showself_reflection = false
    @State private var showSheetAction = false
    @ObservedObject var caseLog: CaseLog

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
                    // add the title here
                    Text(caseLog.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    // add the date here
                    Text(caseLog.date, style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    // we add the descripton here
                    Text(caseLog.description)
                        .font(.body)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.white)
                                .shadow(
                                    color: Color.gray.opacity(0.3),
                                    radius: 10
                                )
                        )
                    
//                    Button(action: {
//                        showSheetAction = true
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
//                    .sheet(isPresented: $showSheetAction) {
//                        EditCaseLogView(caseLog: $caseLog) {
//                            showSheetAction = false
//                        } onCancel: {
//                            showSheetAction = false
//                        }
//                    }
                    
                    Spacer()
                    
                    // Self-reflection Button
                    Button(action: {
                        showself_reflection = true
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
                                radius: 8
                            )
                    }
                    .sheet(isPresented: $showself_reflection) {
                        SelfReflectionView(caseLog: caseLog, selfRef: caseLog.selfRef, showself_reflection: $showself_reflection)
                            .environmentObject(trainee)
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

