//
//  IDInput_faculty.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 12/5/24.
//

import SwiftUI

struct IDInput_faculty: View {
    @EnvironmentObject var data: ScheduleData
    @State var selectedFaculty: Faculty = Faculty()
    
    @State var confirmed: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private func toggleSelection(_ facultyID: String, _ faculty: Faculty) {
        if selectedFaculty.id != facultyID {
            confirmed = false
        }
        selectedFaculty = faculty
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(data.facultyList, id: \.id) { faculty in
                            FacultyRowView(
                                faculty: faculty,
                                isSelected: selectedFaculty.id == faculty.id,
                                toggleSelection: toggleSelection // MARK: This line is also from gpt
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                if selectedFaculty.id != "" {
                    Button {
                        getFaculty(selectedFaculty.id)
                        getCases(selectedFaculty.caseID)
                        getRelatedTrainees(selectedFaculty.caseID)
                        confirmed = true
                    } label: {
                        Text("Confirm")
                    }
                }
                
                if confirmed == true {
                    NavigationLink{
                        FacultyMain().environmentObject(Faculty.activeFaculty)
                    }label: {
                        Text("Go to Faculty View")
                    }
                }
            }
            .onAppear {
//                getAllTrainees()
//                getAllFaculties()
//                getAllCases()
                // MARK: This Error Handler comes from chatGpt
                getAllTrainees { error in
                    self.handleNetworkError(error)
                }
                getAllFaculties { error in
                    self.handleNetworkError(error)
                }
                getAllCases { error in
                    self.handleNetworkError(error)
                }
                // MARK: END
            }
        }
        
    }
    // MARK: This Error Handler comes from chatGpt
    private func handleNetworkError(_ error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                self.alertMessage = "No network connection, please check your network settings。"
            case .timedOut:
                self.alertMessage = "Request timed out, please try again later."
            default:
                self.alertMessage = "Could not connect to the server, please try again later."
            }
        } else {
            self.alertMessage = "An unknown error has occurred：\(error.localizedDescription)"
        }
        self.showAlert = true
    }
    // MARK: END
}

struct FacultyRowView: View {
    let faculty: Faculty
    let isSelected: Bool
    let toggleSelection: (String, Faculty) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("\(faculty.fName) \(faculty.lName)")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("ID: \(faculty.id)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color.blue.opacity(0.2) : Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
        .onTapGesture {
            toggleSelection(faculty.id, faculty)
        }
    }
    
}

//#Preview {
//    IDInput()
//}
