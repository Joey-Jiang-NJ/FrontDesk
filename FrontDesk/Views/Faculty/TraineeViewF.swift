//
//  PersonInfo.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct TraineeViewF: View {
    @EnvironmentObject var trainee: Trainee
    @State private var selectedImage: UIImage? = nil
    @State var showImagePicker = false

    var body: some View {
        NavigationView {
            ZStack {
                // Gradient Background
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                ScrollView {
                    if !trainee.picture.isEmpty {
                        Image(uiImage: imageFromString(trainee.picture))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else {
                        Image("Elaina")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    }
//                    if !trainee.picture.isEmpty {
//                        Image(uiImage: imageFromString(trainee.picture))
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 150, height: 150)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
//                    } else {
//                        Image("Elaina")
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 150, height: 150)
//                            .clipShape(Circle())
//                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
//                    }
                    // show the information of the trainee below
                    VStack(alignment: .leading,spacing: 10) {
                        HStack(spacing: 0){
                            Text("ID:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your trainee ID",
                                text: $trainee.traineeID
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        }.padding()
                        // First name part
                        HStack(spacing: 0){
                            Text("First Name:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your first name",
                                text: $trainee.firstName
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        }.padding()
                        // Last name part
                        HStack(spacing: 0){
                            Text("Last Name:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your last name",
                                text: $trainee.lastName
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        }.padding()
                        // Email part
                        HStack(spacing: 0){
                            Text("Email:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your email",
                                text: $trainee.emailAddress
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        }.padding()
                    }
                    //                .navigationBarItems(leading: Button {
                    //
                    //                } label: {
                    //                    Label("Back", systemImage: "chevron.left")
                    //                        .labelStyle(.titleOnly)
                    //                }
                    //                )
                    
                    
                    
//                    NavigationLink{
//                        RotationHistoryView(curRotation: Rotation.defaultCurRotation, pastRotations: Rotation.defaultPastRotations)
//                            .environmentObject(Trainee.defaultTrainee)
//                    } label: {
//                        Text("Ratation History")
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                    .padding()
                    // link to the rotation part
                    NavigationLink(destination: RotationHistoryView(curRotation: Rotation.defaultCurRotation, pastRotations: Rotation.defaultPastRotations)
                        .environmentObject(trainee)) {
                            HStack {
                                Image(systemName: "doc.text.magnifyingglass")
                                    .font(.title2)
                                Text("Rotation History")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient( colors: [Color.orange, Color.red]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(12)
                       // ButtonContent(label: "Ratation History", icon: "doc.text.magnifyingglass", colors: [Color.orange, Color.red])
                            .frame(width: 350)
                    }
                    
                    // link to the evaluation part
                    NavigationLink(destination: Evaluation(trainee: trainee)) {
                        HStack {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.title2)
                            Text( "Faculty Evaluation")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient( colors: [Color.green, Color.teal]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                       // ButtonContent(label: "Faculty Evaluation", icon: "doc.text.magnifyingglass", colors: [Color.green, Color.teal])
                            .frame(width: 350)
                    }
                    
                    
                }
                // .background(Image("dukehealth").resizable().opacity(0.7))
                .scrollContentBackground(.hidden)
            }
        }
    }
}


//
//#Preview {
//    let trainee = Trainee.defaultTrainee
//    PersonInfoView()
//}
