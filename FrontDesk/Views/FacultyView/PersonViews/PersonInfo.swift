//
//  PersonInfo.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI

struct PersonInfo: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var duid: String = ""
    @State private var netID: String = ""
    @State private var from: String = ""
    @State private var team: String = ""
    @State private var gender: Gender = .Unknown

    @State private var languages: [String]  = ["", "", ""]
    @State private var hobby: String = ""
    @State private var movie: String = ""
    @State private var picture: String = ""
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Personal Information")) {
                    VStack(alignment: .leading){
                        Text("First Name")
                        HStack{
                            Image(systemName: "pencil.line")
                            TextField("First Name", text: $firstName)
                                .foregroundColor(.blue)
                            
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Last Name")
                        HStack{
                            Image(systemName: "pencil.line")
                            TextField("Last Name", text: $lastName)
                                .foregroundColor(.blue)
                        }
                    }
                    VStack(alignment: .leading){
                        Text("DUID")
                        HStack{
                            Image(systemName: "person.text.rectangle")
                            TextField("DUID", text: $duid)
                                .foregroundColor(.blue)
                            //                                .disabled(manipulateOption == .edit)
                            //                            if manipulateOption == .edit {
                            //                                Spacer()
                            //                                Image(systemName: "lock.rectangle")
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("NetID")
                        HStack{
                            Image(systemName: "person.text.rectangle.fill")
                            TextField("NetID", text: $netID)
                                .foregroundColor(.blue)
                            //                            .disabled(manipulateOption == .edit)
                            //                        if manipulateOption == .edit {
                            //                            Spacer()
                            //                            Image(systemName: "lock.rectangle")
                            //                        }
                        }
                    }
                }
                
                Section(header: Text("Details")) {
                    VStack(alignment: .leading){
                        Text("From")
                        HStack{
                            Image(systemName: "house")
                            TextField("From", text: $from)
                                .foregroundColor(.blue)
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Team")
                        HStack{
                            Image(systemName: "person.3")
                            TextField("Team", text: $team)
                                .foregroundColor(.blue)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Gender")
                        Picker("Gender", selection: $gender) {
                            ForEach(Gender.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                    
                //                Section(header: Text("Academic")){
                //                    VStack(alignment: .leading) {
                //                        Text("Role")
                //                        Picker("Role", selection: $role) {
                //                            ForEach(Role.allCases, id: \.self) {
                //                                Text($0.rawValue)
                //                            }
                //                        }
                //                        .pickerStyle(SegmentedPickerStyle())
                //                    }
                //                    VStack(alignment: .leading) {
                //                        Picker("Plan", selection: $plan) {
                //                            ForEach(Plan.allCases, id: \.self) {
                //                                Text($0.rawValue)
                //                            }
                //                        }
                //                        .pickerStyle(DefaultPickerStyle())
                //                    }
                //                    VStack(alignment: .leading) {
                //                        Picker("Program", selection: $program) {
                //                            ForEach(Program.allCases, id: \.self) {
                //                                Text($0.rawValue)
                //                            }
                //                        }
                //                        .pickerStyle(WheelPickerStyle())
                //                    }
                //                }
                    
                //                Section(header: Text("Programming Languages")) {
                //                    VStack(alignment: .leading){
                //                        TextField("Programming language 1", text: $languages[0])
                //                            .foregroundColor(.blue)
                //                    }
                //                    VStack(alignment: .leading){
                //                        TextField("Programming language 2", text: $languages[1])
                //                            .foregroundColor(.blue)
                //                    }
                //                    VStack(alignment: .leading){
                //                        TextField("Programming language 3", text: $languages[2])
                //                            .foregroundColor(.blue)
                //                    }
                //                }
                    
                Section(header: Text("Interests")) {
                    NavigationLink(destination: PreferenceEdit()) {
                        VStack(alignment: .leading){
                            Text("Hobby")
                            HStack{
                                Image(systemName: "heart.circle")
                                    .foregroundColor(.red)
//                                TextField("Hobby", text: $hobby)
//                                    .foregroundColor(.blue)
                            }
                        }
                    }
                
                                        
                    VStack(alignment: .leading){
                        Text("Favorite Movie Genre")
                        HStack{
                            Image(systemName: "movieclapper")
                            TextField("Movie Genre", text: $movie)
                                .foregroundColor(.blue)
                        }
                    }
                }
                    
                Section(header: Text("Image")) {
                    VStack(alignment: .leading){
                        Text("Photo")
                        HStack{
                            Image(systemName: "person.and.background.dotted")
                            TextField("Photo", text: $picture)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
                

        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
}

#Preview {
    PersonInfo()
}
