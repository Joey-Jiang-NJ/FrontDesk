//
//  PreferenceEdit.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI

struct PreferenceEdit: View {
    @EnvironmentObject var faculty: Faculty
    
//    @State private var preferences: [String: String] = [
//        "Preoperative communication": "",
//        "Preop assessment": "",
//        "Preop orders": "",
//        "Premedication": "",
//        "Maintenance": "",
//        "Pain Management": "",
//        "Fluid Management": "",
//        "Postoperative Orders": ""
//    ]

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text("Edit Preferences")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.cyan]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)

                ScrollView {
                    ForEach(faculty.preferences.keys.sorted(), id: \.self) { key in
                        VStack(alignment: .leading) {
                            Text(key)
                                .font(.headline)
                                .foregroundColor(.primary)
                            // MARK: Begin - from chatgpt
                            TextField("Enter \(key.lowercased()) details...", text: Binding(
                                get: { faculty.preferences[key] ?? "" },
                                set: { faculty.preferences[key] = $0 }
                            ))
                            // MARK: End
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical, 5)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.9))
                                .shadow(color: Color.black.opacity(0.1), radius: 5)
                        )
                        .padding(.horizontal)
                    }
                }

                // Save button
                Button(action: savePreferences) {
                    Text("Save Preferences")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.4), radius: 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
    }

    func savePreferences() {
        // Logic to save entered preferences
        var f_ = Faculty_(id: UUID(uuidString: faculty.id), firstName: faculty.fName, lastName: faculty.lName, email: faculty.email)
        f_.preferences = faculty.preferences
        updateFaculty(serverURL: "http://vcm-44136.vm.duke.edu:8080/", faculty: f_) { result in
            switch result {
            case .success(let response):
                print("Update succeeded with status code: \(response.statusCode)")
            case .failure(let error):
                print("Update failed: \(error.localizedDescription)")
            }
        }
    }
}


//struct PreferenceBlock: View {
//    let title: String
//    let options: [String]
//    @State var selectedOption: String
//    let onSelectOption: (String) -> Void
//
//    var shouldStackVertically: Bool {
//        options.count > 3 || options.contains { $0.count > 10 }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.primary)
//                .padding(.bottom, 5)
//
//            // Options Layout
//            if shouldStackVertically {
//                VStack(spacing: 10) {
//                    ForEach(options, id: \.self) { option in
//                        PreferenceButton(option: option, selectedOption: $selectedOption, onSelectOption: onSelectOption)
//                    }
//                }
//            } else {
//                HStack(spacing: 10) {
//                    ForEach(options, id: \.self) { option in
//                        PreferenceButton(option: option, selectedOption: $selectedOption, onSelectOption: onSelectOption)
//                    }
//                }
//            }
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 12)
//                .fill(Color.white.opacity(0.9))
//                .shadow(color: Color.black.opacity(0.1), radius: 5)
//        )
//    }
//}

//struct PreferenceButton: View {
//    let option: String
//    @Binding var selectedOption: String
//    let onSelectOption: (String) -> Void
//
//    var body: some View {
//        Button(action: {
//            selectedOption = option
//            onSelectOption(option)
//        }) {
//            Text(option)
//                .font(.subheadline)
//                .foregroundColor(.white)
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(
//                    selectedOption == option ? Color.blue : Color.gray
//                )
//                .cornerRadius(10)
//                .shadow(color: selectedOption == option ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2), radius: 3)
//        }
//    }
//}
//
//#Preview {
//    PreferenceEdit()
//}



// Sample preferences
//let samplePreferences = [
//    Preference(title: "Preoperative Communication", options: ["Thorough", "Brief", "Delegated"]),
//    Preference(title: "Pain Management", options: ["Opioids", "Non-Opioids", "Multimodal"]),
//    Preference(title: "Fluid Management", options: ["Liberal", "Restrictive", "Standard"]),
//]

//struct Preference: Identifiable {
//    let id = UUID()
//    let title: String
//    let options: [String]
//}


// self-define the preference buttons (Using "onTapGesture")
//struct PreferenceOptions: View {
//    var title: String
//    var isSelected: Bool
//    let size: CGFloat
//    let action: () -> Void
//    
//    let options: [String]
//    @State var selectedOption: Int?
//    
////    @State var selected: [String]
//    
//    var shouldVstack: Bool {
//        options.count > 3 || options.contains{ $0.count > 3 }
//    }
//    
//    
//    
//    var body: some View {
//        Group {
//            if shouldVstack {
//                VStack {
//                    ForEach(options.indices, id: \.self) { index in
//                        PreferenceButton(for: index)
//                    }
//                }
//                
//            } else {
//                HStack {
//                    ForEach(options.indices, id: \.self) { index in
//                        PreferenceButton(for: index)
//                    }
//                }
//            }
//        }
//    }
//    
//    
//    private func PreferenceButton(for index: Int) -> some View {
//        Button(action: {
//            if(selectedOption == index){
//                selectedOption = nil
//            } else {
//                selectedOption = index
//            }
//        }){
//            Text(title)
//                .font(.body)
//                .foregroundColor(.white)
//                .frame(width: size)
//                .padding()
//                .background(isSelected ? Color.blue : Color.gray)
//                .cornerRadius(10)
////                .onTapGesture {
////                    action()
////                }
//        }
//        
//    }
//}

//#Preview{
//    PreferenceEdit()
//}
