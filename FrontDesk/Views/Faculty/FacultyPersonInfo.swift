//
//  PersonInfo.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI



struct FacultyPersonInfo: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var from: String = ""
    @State private var team: String = ""
    @State private var gender: Gender = .Unknown
    @EnvironmentObject var faculty: Faculty
    
    @State var emptyName: Bool = false
    @State var wrongName: Bool = false
    @State var wrongEmail: Bool = false
    
    @State var showAlert: Bool = false
    
    @State var alertType: AlertType = .unknown
    

    private func checkName(str: String) {
        let pattern = "(Dr\\. [a-zA-Z]*)|[a-zA-Z]*$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: str.utf16.count)
        let match = regex.firstMatch(in: str, options: [], range: range)
        if match != nil && match?.range == range {
            wrongName = false
        } else {
            wrongName = true
        }
    }

    
    private func checkEmail(str: String) {
        if str.isEmpty {
            wrongEmail = false
            return
        }
        let pattern = "[A-Z0-9a-z._]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,}$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: str.utf16.count)
        let match = regex.firstMatch(in: str, options: [], range: range)
        if match != nil && match?.range == range {
            wrongEmail = false
        } else {
            wrongEmail = true
        }
    }

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                Text("Faculty Information")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.cyan]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .padding(.top, 30)
                    .shadow(color: Color.black.opacity(0.2), radius: 10)

                Form {
                    // Personal Information Section
                    Section(header: CustomHeader(title: "Personal Information", icon: "person.crop.circle")) {
                        if wrongName {
                            Text("First or last name in wrong format.")
                                .foregroundStyle(.red)
                                .padding()
                        }
                        CustomField(title: "First Name", text: $faculty.fName, icon: "pencil.line", color: .blue)
                            .onChange(of: faculty.fName) { ov, nv in
                                checkName(str: nv)
                            }
                        CustomField(title: "Last Name", text: $faculty.lName, icon: "pencil.line", color: .blue)
                            .onChange(of: faculty.lName) { ov, nv in
                                checkName(str: nv)
                            }
                        if wrongEmail {
                            Text("Email in wrong format.")
                                .foregroundStyle(.red)
                                .padding()
                        }
                        CustomField(title: "Email", text: $faculty.email, icon: "recordingtape", color: .blue)
                            .onChange(of: faculty.email) { ov, nv in
                                checkEmail(str: nv)
                            }
                    }

//                    // Details Section
//                    Section(header: CustomHeader(title: "Details", icon: "info.circle")) {
//                        CustomField(title: "From", text: $from, icon: "house", color: .green)
//                        CustomField(title: "Team", text: $team, icon: "person.3", color: .purple)
//
//                        VStack(alignment: .leading) {
//                            Text("Gender")
//                                .font(.subheadline)
//                                .fontWeight(.bold)
//                                .foregroundColor(.secondary)
//                            Picker("Gender", selection: $gender) {
//                                ForEach(Gender.allCases, id: \.self) {
//                                    Text($0.rawValue)
//                                }
//                            }
//                            .pickerStyle(SegmentedPickerStyle())
//                        }
//                    }
                    
//                    // Email Section
//                    Section(header: CustomHeader(title: "Email", icon: "recordingtape")) {
//
//                    }

                    // Next, we do the Preferences Section
                    Section {
                        NavigationLink(destination: PreferenceEdit().environmentObject(faculty)) {
                            HStack {
                                Text("Preferences")
                                    .font(.subheadline)
                                Spacer()
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.8))
                        .shadow(color: Color.black.opacity(0.1), radius: 10)
                )
                .padding()
            }
            .toolbar {
                // we can save here and put the save button at the end of the toolbar
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    if faculty.fName.isEmpty || faculty.lName.isEmpty{
                                        alertType = .emptyNameAlert
                                        showAlert = true
                                    } else if wrongName == true {
                                        alertType = .wrongNameAlert
                                        showAlert = true
                                    } else if wrongEmail == true {
                                        alertType = .wrongEmailAlert
                                        showAlert = true
                                    } else {
                                        upLoadFaculty(faculty)
                                    }
                                }
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            }
                        }
                    
        }
        .alert(isPresented: $showAlert) {
            switch alertType {
            case .emptyNameAlert:
                return Alert(title: Text("First or last name can not be empty."))
            case .wrongNameAlert:
                return Alert(title: Text("First or last name in wrong format."))
            case .wrongEmailAlert:
                return Alert(title: Text("Email address in wrong format."))
            case .unknown:
                return Alert(title: Text("Unknown error."))
            }
        }
//        .onAppear {
//            self.firstName = "Dr. Emily"
//            self.lastName = "Clark"
//            self.from = "USA"
//            self.team = "Team A"
//            self.gender = .Female
//        }
    }
}

// make the user able to edit the information
struct CustomField: View {
    let title: String
    @Binding var text: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                TextField(title, text: $text)
                    .foregroundColor(.primary)
            }
            .padding(8)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .padding(.vertical, 5)
    }
}

struct CustomHeader: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
    }
}



#Preview {
    FacultyPersonInfo()
}
