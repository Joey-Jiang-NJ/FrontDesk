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
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)

                Form {
                    // Personal Information Section
                    Section(header: CustomHeader(title: "Personal Information", icon: "person.crop.circle")) {
                        CustomField(title: "First Name", text: $firstName, icon: "pencil.line", color: .blue)
                        CustomField(title: "Last Name", text: $lastName, icon: "pencil.line", color: .blue)
                    }

                    // Details Section
                    Section(header: CustomHeader(title: "Details", icon: "info.circle")) {
                        CustomField(title: "From", text: $from, icon: "house", color: .green)
                        CustomField(title: "Team", text: $team, icon: "person.3", color: .purple)

                        VStack(alignment: .leading) {
                            Text("Gender")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)
                            Picker("Gender", selection: $gender) {
                                ForEach(Gender.allCases, id: \.self) {
                                    Text($0.rawValue)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }

                    // Preferences Section
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
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
                )
                .padding()
            }
            .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button("Save") {
                                    //TODO
                                }
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            }
                        }
                    
        }
        .onAppear {
            self.firstName = "Dr. Emily"
            self.lastName = "Clark"
            self.from = "USA"
            self.team = "Team A"
            self.gender = .Female
        }
    }
}

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
