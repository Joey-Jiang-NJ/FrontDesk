//
//  Evaluation.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI

struct Evaluation: View {
    @ObservedObject var trainee: Trainee
    @State var op1: Int?
    @State var op2: Int?
    @State var op3: Int?
    @State var op4: Int?
    
    @State var showSave: Bool = true
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    Text("Faculty Evaluation")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5)

                    // Categories Section
                    Text("Evaluation Categories")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading)

                    VStack(spacing: 10) {
                        EvaluationCategory(name: "Preop Assessment")
                        EvaluationCategory(name: "Intraop Management")
                        EvaluationCategory(name: "Anesthesia Procedures")
                        EvaluationCategory(name: "Professionalism/Communication")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )

                    // Feedback Cards
                    Text("Feedback Questions")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.leading)

                    VStack(spacing: 20) {
                        FeedbackCard(
                            title: "Demonstrates adequate listening skills",
                            options: ["Yes", "No", "N/A"],
                            selectedOption: $op1
                        )
                        FeedbackCard(
                            title: "Communicates effectively in routine clinical situations",
                            options: ["Yes", "No", "N/A"],
                            selectedOption: $op2
                        )
                        FeedbackCard(
                            title: "Checks for patient and family understanding of illness and management plan",
                            options: ["Yes", "No", "N/A"],
                            selectedOption: $op3
                        )
                        FeedbackCard(
                            title: "Position the patient",
                            options: ["Show and Tell", "Active Help", "Passive Help", "Supervision Only", "Expert", "Not Performed"],
                            selectedOption: $op4
                        )
                    }
                    .padding(.horizontal)
                }

                // Save Button
                // begin to calculate the score of the trainee
                if showSave == true {
                    Button(action: {
                        var score: Double = 0
                        // YES for 2, NO for 1, N/A for 0
                        if op1 == 0 {
                            score += 2
                        } else if op1 == 1 {
                            score -= 1
                        }
                        
                        if op2 == 0 {
                            score += 2
                        } else if op2 == 1 {
                            score -= 1
                        }
                        
                        if op3 == 0 {
                            score += 2
                        } else if op3 == 1 {
                            score -= 1
                        }
                        
                        if op4 == 0 {
                            score += 2
                        } else if op4 == 1 {
                            score += 3
                        } else if op4 == 2 {
                            score += 2
                        } else if op4 == 3 {
                            score += 1
                        } else if op4 == 4 {
                            score += 4
                        } else if op4 == 5 {
                            score -= 1
                        }
                        
                        trainee.evalScore = (Double(trainee.evalScore)*Double(trainee.evalCount) + score)/(Double(trainee.evalCount)+1)
                        trainee.evalCount += 1
                        trainee.isAvailableForCase = true
                        trainee.caseID = ""
    //                    print(trainee.firstName, trainee.evalCount, trainee.evalScore)
                        
                        upLoadTrainee(trainee)
                        showSave = false
                        
                    }) {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                            .shadow(color: Color.blue.opacity(0.4), radius: 5)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

struct EvaluationCategory: View {
    let name: String

    var body: some View {
        Text("• \(name)")
            .font(.body)
            .foregroundColor(.primary)
            .padding(.vertical, 8)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.9))
                    .shadow(color: Color.black.opacity(0.1), radius: 3)
            )
    }
}

struct FeedbackCard: View {
    let title: String
    let options: [String]
    @Binding var selectedOption: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, 5)

            FeedbackOptions(selectedOption: $selectedOption, options: options)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct FeedbackOptions: View {
    @Binding var selectedOption: Int?
    var options: [String]
// MARK: WE learned this from gpt
    var shouldVStack: Bool {
        options.count > 4 || options.contains { $0.count > 10 }
    }
    // MARK: END

    var body: some View {
        Group {
            if shouldVStack {
                VStack {
                    ForEach(options.indices, id: \.self) { index in
                        selectionButton(for: index)
                    }
                }
            } else {
                HStack {
                    ForEach(options.indices, id: \.self) { index in
                        selectionButton(for: index)
                    }
                }
            }
        }
    }

    private func selectionButton(for index: Int) -> some View {
        Button(action: {
            if selectedOption == index {
                selectedOption = nil
            } else {
                selectedOption = index
            }
        }) {
            Text(options[index])
                .font(.subheadline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    selectedOption == index ? Color.blue : Color.gray
                )
                .cornerRadius(10)
                .shadow(color: selectedOption == index ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2), radius: 3)
        }
    }
}

//#Preview {
//    Evaluation()
//}
