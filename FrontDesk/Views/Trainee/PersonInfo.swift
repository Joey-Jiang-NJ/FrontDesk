//
//  PersonInfo.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct PersonInfoView: View {
    @EnvironmentObject var trainee: Trainee
    @State var edit: Bool = false
    @Binding var image: UIImage?
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
                    if image == nil {
                        if !trainee.picture.isEmpty {
                            Image(uiImage: imageFromString(trainee.picture))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        } else {
                            Image("Elaina")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        }
                    } else {
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        }
                    }
                    if edit == true {
                        Button("Upload Image") {
                            showImagePicker = true
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(selectedImage: $image)
                        }
                    }
                    
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
                            .disabled(!edit)
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
                            .disabled(!edit)
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
                            .disabled(!edit)
                        }.padding()
                    }
                    //                .navigationBarItems(leading: Button {
                    //                        
                    //                } label: {
                    //                    Label("Back", systemImage: "chevron.left")
                    //                        .labelStyle(.titleOnly)
                    //                }
                    //                )
                    
                    
                    Button{
                        edit = true
                    } label: {
                        Text("Edit Personal Info")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    if edit {
                        Button{
                            // TODO
                            if image != nil{
                                trainee.picture = stringFromImage(image!)
                            }
                            edit = false
                        } label: {
                            Text("Save")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
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
            .onAppear{
                if !trainee.picture.isEmpty{
                    image = imageFromString(trainee.picture)
                }
            }
        }
    }
}


//
//#Preview {
//    let trainee = Trainee.defaultTrainee
//    PersonInfoView()
//}
