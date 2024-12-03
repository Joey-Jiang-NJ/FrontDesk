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
                    if trainee.traineeID.lowercased() == "076eee0e-04bf-413a-8dc1-5a52ed8ee7b7" {
                        Image("head")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else if trainee.firstName == "Sarah" {
                        Image("head1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else if trainee.firstName == "Michael" {
                        Image("head2")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else if trainee.firstName == "Emily" {
                        Image("head3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    } else if trainee.lastName == "Brown" {
                        Image("head4")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    }
                    else {
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
                        
                        HStack(spacing: 0){
                            Text("Last Name:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your first name",
                                text: $trainee.lastName
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        }.padding()
                        
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
                    
                    
                    
                    NavigationLink{
                        RotationHistoryView(curRotation: Rotation.defaultCurRotation, pastRotations: Rotation.defaultPastRotations)
                            .environmentObject(Trainee.defaultTrainee)
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
