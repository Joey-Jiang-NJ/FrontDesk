//
//  Evaluation.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI

struct Evaluation: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Faculty Evaluation")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                
                // list for evaluation
                VStack(alignment: .leading) {
                    EvaluationCategory(name: "• Preop Assessment")
                    EvaluationCategory(name: "• Intraop Management")
                    EvaluationCategory(name: "• Anesthesia Procedures")
                    EvaluationCategory(name: "• Professionalism/Communication")
                }
                .padding(.leading)
                
                Divider()
                
                // feedback card examples
                VStack {
                    FeedbackCard(
                        title:"Demonstrates adequate listening skills",
                        options: ["Yes", "No", "N/A"]
                    )
                    FeedbackCard(
                        title: "Communicates effectively in routine clinical situations",
                        options: [
                            "Yes",
                            "No",
                            "N/A"
                        ]
                    )
                    FeedbackCard(
                        title: "Checks for patient and family understanding of illness and management plan",
                        options: [
                            "Yes",
                            "No",
                            "N/A"
                        ]
                    )
                    FeedbackCard(
                        title: "Position the patient",
                        options: [
                            "Show and Tell",
                            "Active Help",
                            "Passive Help",
                            "Supervision Only",
                            "Expert",
                            "Not Performed"
                        ]
                    )
                                                                                           
                }
                
                // feedback card list
                
            }
        }
        Text("Evaluation")
        
    }
}

struct EvaluationCategory: View {
    let name: String
    
    var body: some View {
        Text(name)
            .font(.body)
            .foregroundColor(.primary)
    }
}

struct FeedbackCard: View {
    let title: String
    let options: [String]
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            HStack {
//                ForEach(options, id: \.self) { option in
//                    Text(option)
//                        .font(.caption)
//                        .fontWeight(.medium)
//                        .foregroundColor(.secondary)
//                }
                FeedbackOptions(options: options)
            }
        }
    }
}

struct FeedbackOptions: View {
    @State var selectedOption: Int?
    var options: [String]
    
    var shouldVstack: Bool {
        options.count > 4 || options.contains{$0.count > 4}
    }
    
    var body: some View {
        Group {
            if shouldVstack {
                VStack {
                    ForEach(options.indices, id: \.self) {index in
                        selectionButton(for: index)
                    }
                }
                .padding()
            } else {
                HStack {
                    ForEach(options.indices, id: \.self) {index in
                        selectionButton(for: index)
                    }
                }
                .padding()
            }
        }
    }
    
    private func selectionButton(for index: Int) -> some View {
        Button(action: {
            if(selectedOption == index){
                selectedOption = nil
            } else {
                selectedOption = index
            }
        }){
            Text(options[index])
                .font(.body)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    selectedOption == index ? Color.blue : Color.gray
                )
                .cornerRadius(10)
        }
    }

}


#Preview {
    Evaluation()
}
