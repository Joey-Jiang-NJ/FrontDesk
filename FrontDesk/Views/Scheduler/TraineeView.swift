//
//  PersonInfo.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct TraineeView: View {
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
                    // Again, when there is no picture of trainee, add the default picture
                    if !trainee.picture.isEmpty {
                        Image(uiImage: imageFromString(trainee.picture))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray))
                    } else {
                        Image("Elaina")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray))
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
                    // first show the information of the selected trainee
                    VStack(alignment: .leading,spacing: 10) {
                        HStack(){
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
                        
                        HStack(){
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
                        
                        HStack(){
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
                        
                        HStack(){
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
                    
                    
                    // similar to the trainee page, scheduler can also accesss the rotation page of the trainee
                    NavigationLink{
                        RotationHistoryView(curRotation: Rotation.defaultCurRotation, pastRotations: Rotation.defaultPastRotations)
                            .environmentObject(trainee)
                    } label: {
                        Text("Ratation History")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                    
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
