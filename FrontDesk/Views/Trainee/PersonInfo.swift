//
//  PersonInfo.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

enum AlertType {
    case emptyNameAlert, wrongNameAlert, wrongEmailAlert, unknown
}

struct PersonInfoView: View {
    @EnvironmentObject var trainee: Trainee
    @State var edit: Bool = false
    @Binding var image: UIImage?
    @State private var selectedImage: UIImage? = nil
    @State var showImagePicker = false
    
    @State var emptyName: Bool = false
    @State var wrongName: Bool = false
    @State var wrongEmail: Bool = false
    
    @State var showAlert: Bool = false
    
    @State var alertType: AlertType = .unknown
    

    private func checkName(str: String) {
        let pattern = "[a-zA-Z]*$"
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
        NavigationView {
            ZStack {
                // add the gradient Background
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
                                .overlay(Circle().stroke(Color.gray))
                        } else {
                            Image("Elaina")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray))
                        }
                    } else {
                        if let image = self.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray))
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
                    // First ask the user to enter the trainee ID
                    
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
                            // The id is not changable
                            .disabled(true)
                        }.padding()
                        
                        if wrongName {
                            Text("First or last name in wrong format.")
                                .foregroundStyle(.red)
                                .padding()
                        }
                        // The first name area
                        HStack(spacing: 0){
                            Text("First Name:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your first name",
                                text: $trainee.firstName
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            // user can change the first name place
                            .disabled(!edit)
                            .onChange(of: trainee.firstName) { ov, nv in
                                checkName(str: nv)
                            }
                        }.padding()
                        
                        // The last name area
                        HStack(spacing: 0){
                            Text("Last Name:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your last name",
                                text: $trainee.lastName
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            // The users can edit the last name area
                            .disabled(!edit)
                            .onChange(of: trainee.lastName) { ov, nv in
                                checkName(str: nv)
                            }
                        }.padding()
                        
                        if wrongEmail {
                            Text("Email in wrong format.")
                                .foregroundStyle(.red)
                                .padding()
                        }
                        // the email area
                        HStack(spacing: 0){
                            Text("Email:").bold()
                                .frame(width: 100, alignment: .leading)
                            TextField(
                                "Enter your email",
                                text: $trainee.emailAddress
                            )
                            .autocapitalization(.none)
                            .textFieldStyle(.roundedBorder)
                            // people can eedit the email area
                            .disabled(!edit)
                            .onChange(of: trainee.emailAddress) { ov, nv in
                                checkEmail(str: nv)
                            }
                        }.padding()
                    }
                    //                .navigationBarItems(leading: Button {
                    //
                    //                } label: {
                    //                    Label("Back", systemImage: "chevron.left")
                    //                        .labelStyle(.titleOnly)
                    //                }
                    //                )
                    
                    
                    // only when user click the button, they are able to edit
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
                    
                    //here is the upload section
                    if edit {
                        Button{
                            // TODO
                            if trainee.firstName.isEmpty || trainee.lastName.isEmpty{
                                alertType = .emptyNameAlert
                                showAlert = true
                            } else if wrongName == true {
                                alertType = .wrongNameAlert
                                showAlert = true
                            } else if wrongEmail == true {
                                alertType = .wrongEmailAlert
                                showAlert = true
                            } else {
                                if image != nil{
                                    // save the image when the user clicks the save button
                                    trainee.picture = stringFromImage(image!)
    //                                print(trainee.picture)
                                }
                                upLoadTrainee(trainee)
                                edit = false
                            }
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
                            .environmentObject(Trainee.activeTrainee)
                    } label: {
                        Text("Rotation History")
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
