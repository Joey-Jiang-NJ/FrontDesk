//
//  SelfReflection.swift
//  FrontDesk
//
//  Created by DJY on 10/25/24.
//

import SwiftUI

struct SelfReflectionView: View {
    @EnvironmentObject var trainee: Trainee
    @ObservedObject var caseLog: CaseLog
    
    @State var selfRef: SelfReflection = SelfReflection()
    
    @Binding var showself_reflection: Bool
    
    let procedureLevels = ["N", "AN", "A", "C", "E"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Indication Section
                HStack {
                    Image(systemName: "list.bullet").foregroundColor(.blue)
                    Text("Questions").font(.title2).fontWeight(.bold)
                    Spacer()
                }
                .padding(.top)

                VStack(alignment: .leading) {
                    Text("Indication").font(.headline)
                    TextField("Enter indication here", text: $selfRef.indication)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Procedure Key Steps Section
                VStack(alignment: .leading) {
                    Text("Procedure Key Steps").font(.headline)
                    // MARK: We learned how to use dictionary in forEach  from gpt
                    ForEach(Array(selfRef.keySteps.enumerated()), id: \.offset) { index, step in
                        VStack {
                            if selfRef.editingIndex == index {
                                VStack {
                                    TextField("Edit step", text: $selfRef.editedText)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                HStack {
                                    // call the save edit function when you click the save button
                                    Button(action: {
                                        saveEdit(at: index)
                                    }) {
                                        Label("Save", systemImage: "checkmark")
                                            .padding(6)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(7)
                                    }
                                    // similarly, call cancelEdit when you click cancel button
                                    Button(action: {
                                        cancelEdit()
                                    }) {
                                        Label("Cancel", systemImage: "xmark")
                                            .padding(6)
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(7)
                                    }
                                }
                            } else {
                                VStack {
                                    Text(step)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                HStack {
                                    Button(action: {
                                        startEdit(at: index)
                                    }) {
                                        Label("Edit", systemImage: "pencil")
                                            .padding(6)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(7)
                                    }
                                    Button(action: {
                                        moveStep(at: index)
                                    }) {
                                        Label("Move", systemImage: "arrow.up.arrow.down")
                                            .padding(4)
                                            .background(Color.gray)
                                            .foregroundColor(.white)
                                            .cornerRadius(6)
                                    }
                                    Button(action: {
                                        deleteStep(at: index)
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                            .padding(6)
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    // add new step when you click add button
                    Button(action: {
                        addNewStep()
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Procedure")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                }

                // Overall Assessed Procedure Level Section
                VStack(alignment: .leading) {
                    Text("Overall Assessed Procedure Level")
                        .font(.headline)
                    HStack {
                        ForEach(procedureLevels, id: \.self) { level in
                            Button(action: {
                                selfRef.selectedProcedureLevel = level
                            }) {
                                Text(level)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(width: 50, height: 50)
                                    .background(
                                        selfRef.selectedProcedureLevel == level ? Color.blue : Color.gray.opacity(0.3)
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }

                // Key Steps Reviewed Section
                VStack(alignment: .leading) {
                    Text("Were the key steps reviewed prior to performing the procedure?")
                        .font(.headline)
                    HStack {
                        Button("Yes") {
                            selfRef.reviewed = true // when the user clicked YES buttton, set reviewed to yes
                        }
                        .padding()
                        // change the color of the button when the user click it
                        .background(selfRef.reviewed == true ? Color.blue : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Button("No") {
                            selfRef.reviewed = false// when the user clicked NO buttton, set reviewed to NO
                        }
                        .padding()
                        // change the color of the button when the user click it
                        .background(selfRef.reviewed == false ? Color.red : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }

                // Faculty and Learner Feedback Section
                VStack(alignment: .leading) {
                    Text("Faculty Sally: What went well?").font(.headline)
                    TextField("Enter feedback here", text: $selfRef.facultyFeedback[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Faculty Sally: What can be improved?").font(.headline)
                    TextField("Enter feedback here", text: $selfRef.facultyFeedback[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Learner Jim: What went well?").font(.headline)
                    TextField("Enter feedback here", text: $selfRef.learnerFeedback[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Learner Jim: What can be improved?").font(.headline)
                    TextField("Enter feedback here", text: $selfRef.learnerFeedback[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Save Button
                Button(action: {
                    // Save self-reflection here
                    caseLog.selfRef = selfRef
                    _ = trainee.saveToArchCL()
                    showself_reflection = false
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Save").fontWeight(.bold)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
                }
                .padding(.bottom)
            }
            .padding()
        }
    }

    //  Action Functions
    func startEdit(at index: Int) {
        selfRef.editingIndex = index
        selfRef.editedText = selfRef.keySteps[index]
    }

    func saveEdit(at index: Int) {
        selfRef.keySteps[index] = selfRef.editedText
        cancelEdit()
    }

    func cancelEdit() {
        selfRef.editingIndex = nil
        selfRef.editedText = ""
    }
    // MARK: - we learned this function from gpt
    func moveStep(at index: Int) {
        guard index > 0 else { return }
        let step = selfRef.keySteps.remove(at: index)
        selfRef.keySteps.insert(step, at: 0)
    }
    // MARK: END

    func deleteStep(at index: Int) {
        selfRef.keySteps.remove(at: index)
    }

    func addNewStep() {
        let newStepNumber = selfRef.keySteps.count + 1
        selfRef.keySteps.append("Step \(newStepNumber)")
    }
}
