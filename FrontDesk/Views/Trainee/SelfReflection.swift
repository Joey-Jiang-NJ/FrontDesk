//
//  SelfReflection.swift
//  FrontDesk
//
//  Created by DJY on 10/25/24.
//

import SwiftUI

struct SelfReflectionView: View {
    @State private var indication: String = ""
    @State private var reviewed: Bool? = nil
    @State private var facultyFeedback: [String] = ["", ""]
    @State private var learnerFeedback: [String] = ["", ""]
    @State private var keySteps: [String] = ["Step 1", "Step 2", "Step 3"]
    @State private var editingIndex: Int? = nil
    @State private var editedText: String = ""
    @State private var selectedProcedureLevel: String? = nil // Track selected procedure level

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
                    TextField("Enter indication here", text: $indication)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Procedure Key Steps Section
                VStack(alignment: .leading) {
                    Text("Procedure Key Steps").font(.headline)
                    ForEach(Array(keySteps.enumerated()), id: \.offset) { index, step in
                        VStack {
                            if editingIndex == index {
                                VStack {
                                    TextField("Edit step", text: $editedText)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                HStack {
                                    Button(action: {
                                        saveEdit(at: index)
                                    }) {
                                        Label("Save", systemImage: "checkmark")
                                            .padding(6)
                                            .background(Color.green)
                                            .foregroundColor(.white)
                                            .cornerRadius(7)
                                    }
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
                                selectedProcedureLevel = level
                            }) {
                                Text(level)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(width: 50, height: 50)
                                    .background(
                                        selectedProcedureLevel == level ? Color.blue : Color.gray.opacity(0.3)
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
                            reviewed = true
                        }
                        .padding()
                        .background(reviewed == true ? Color.blue : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        Button("No") {
                            reviewed = false
                        }
                        .padding()
                        .background(reviewed == false ? Color.red : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }

                // Faculty and Learner Feedback Section
                VStack(alignment: .leading) {
                    Text("Faculty Sally: What went well?").font(.headline)
                    TextField("Enter indication here", text: $facultyFeedback[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Faculty Sally: What can be improved?").font(.headline)
                    TextField("Enter indication here", text: $facultyFeedback[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Learner Jim: What went well?").font(.headline)
                    TextField("Enter indication here", text: $learnerFeedback[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Learner Jim: What can be improved?").font(.headline)
                    TextField("Enter indication here", text: $learnerFeedback[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                // Save Button
                Button(action: {
                    // Save self-reflection here
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

    // MARK: - Action Functions
    func startEdit(at index: Int) {
        editingIndex = index
        editedText = keySteps[index]
    }

    func saveEdit(at index: Int) {
        keySteps[index] = editedText
        cancelEdit()
    }

    func cancelEdit() {
        editingIndex = nil
        editedText = ""
    }

    func moveStep(at index: Int) {
        guard index > 0 else { return }
        let step = keySteps.remove(at: index)
        keySteps.insert(step, at: 0)
    }

    func deleteStep(at index: Int) {
        keySteps.remove(at: index)
    }

    func addNewStep() {
        let newStepNumber = keySteps.count + 1
        keySteps.append("Step \(newStepNumber)")
    }
}

#Preview {
    SelfReflectionView()
}
