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
    @State private var facultyFeedback: [String] = ["", ""] // can add more later
    @State private var learnerFeedback: [String] = ["", ""] // can add more later
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
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
                
                // Procedure Key Steps
                VStack(alignment: .leading) {
                    Text("Procedure Key Steps").font(.headline)
                    VStack(spacing: 10) {
                       
                            HStack {
                                Text("Step 1")
                                    .foregroundColor(.gray)
                                Spacer()
                                Button(action: {}) {
                                    Label("Edit", systemImage: "pencil").padding(6).background(Color.blue).foregroundColor(.white)
                                        .cornerRadius(7)
                                }
                                Button(action: {}) {
                                    Label("Move", systemImage: "arrow.up.arrow.down").padding(4)
                                        .background(Color.gray)
                                        .foregroundColor(.white)
                                        .cornerRadius(6)
                                }
                                Button(action: {}) {
                                    Label("Archive", systemImage: "trash")
                                        .padding(6)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                                
                            
                        }
                        HStack {
                            Text("Step 2")
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {}) {
                                Label("Edit", systemImage: "pencil").padding(6)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(7)
                            }
                            Button(action: {}) {
                                Label("Move", systemImage: "arrow.up.arrow.down").padding(4)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                            Button(action: {}) {
                                Label("Archive", systemImage: "trash")
                                    .padding(6)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                        
                    }
                        HStack {
                            Text("Step 3")
                                .foregroundColor(.gray)
                            Spacer()
                            Button(action: {}) {
                                Label("Edit", systemImage: "pencil").padding(6)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(7)
                            }
                            Button(action: {}) {
                                Label("Move", systemImage: "arrow.up.arrow.down").padding(4)
                                    .background(Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(6)
                            }
                            Button(action: {}) {
                                Label("Archive", systemImage: "trash")
                                    .padding(6)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                        
                    }
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                }
                
                // Overall Assessed Procedure Level
                VStack(alignment: .leading) {
                    Text("Overall Assessed Procedure Level")
                        .font(.headline)
                    HStack {
                       
                        ForEach(["N", "AN", "A", "C", "E"], id: \.self) { pro_level in
                            Text(pro_level)
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(8)
                        }
                    }
                    .padding().background(Color.gray.opacity(0.1)).cornerRadius(10)
                }
                
                // Key Steps Reviewed
                VStack(alignment: .leading) {
                    Text("Were the key steps reviewed prior to performing the procedure?")
                        .font(.headline)
                    HStack {
                        Button("Yes") {
                            reviewed = true
                        }
                        .padding().background(reviewed == true ? Color.blue : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("No") {
                            reviewed = false
                        }
                        .padding().background(reviewed == false ? Color.red : Color.gray.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Faclulty Sally: What went well?").font(.headline)
                    TextField("Enter indication here", text: $facultyFeedback[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Faclulty Sally: What can be improved?").font(.headline)
                    TextField("Enter indication here", text: $facultyFeedback[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Learner Jim: What went well?").font(.headline)
                    TextField("Enter indication here", text: $learnerFeedback[0])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Learner Jim: What went well?").font(.headline)
                    TextField("Enter indication here", text: $learnerFeedback[1])
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                }
                
                Button(action: {
                    // save self reflection here
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Save").fontWeight(.bold)
                    }
                    .padding().foregroundColor(.white).background(Color.green).cornerRadius(10)
                }
                .padding(.bottom)
                
            }
            .padding()
        }
    }
}



#Preview {
    SelfReflectionView()
}
