//
//  ContentView.swift
//  FrontDesk
//
//  Created by DJY on 10/25/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var trainee: Trainee
    @State var image: UIImage? = UIImage()
    var body: some View {
        NavigationView {
            // Use the Tab view for main page, case log and Person Info
            TabView {
                ContentView()
                    .environmentObject(trainee)
                    .tabItem {
                        Label("Main", systemImage: "house")
                    }
                    .onAppear{
                        image = imageFromString(trainee.picture)
                    }
                CaseLogListView()
                    .tabItem {
                        Label("Case Logs", systemImage: "list.bullet")
                    }
                    .onAppear{
                        image = imageFromString(trainee.picture)
                    }
                PersonInfoView(image: $image)
                    .environmentObject(trainee)
                    .tabItem {
                        Label("Person Info", systemImage: "person.crop.circle")
                    }
                    .onAppear{
                        image = imageFromString(trainee.picture)
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            // Similar to the entrance page, I use the toolbar to place the title
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Front Desk")
                        .font(.custom("BungeeSpice-Regular", size: 35))
                        .fontWeight(.bold)
                        .padding()
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                  
                    NavigationLink{
                        PersonInfoView(image: $image)
                            .environmentObject(trainee)
                    }label:{

                        Image(uiImage: image!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 5)
                    }
                    
                }
            }
            .onAppear{
//                _ = trainee.loadFromArch()
                _ = trainee.loadFromArchCL()
            }
           
        }
    }
}

struct ContentView: View {
    @State var flag: Bool = false // the flag button check if the user clicked the download button
    @EnvironmentObject var trainee: Trainee

    var body: some View {
        ZStack{
            Image("bg2").resizable().ignoresSafeArea().opacity(0.6)
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Ongoing Rotations Section
                    Text("Ongoing rotations")
                        .font(.custom("Pacifico-Regular", size: 32))
                        .bold()
                        .padding()
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [Color.green, Color.blue]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    VStack(alignment: .leading) {
                        // link the rotation text to the roation content
                        NavigationLink(destination: RotationHistoryView(curRotation: Rotation.defaultCurRotation, pastRotations: Rotation.defaultPastRotations).environmentObject(Trainee.activeTrainee)) {
                            HStack {
                                Text("Rotation3")
                                    .font(.subheadline)
                                    .fontWeight(.heavy)
                                    .bold()
                                Spacer()
                              
                            }
                            .padding()
                            // add the background here to make the text more obvious
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(6)
                        }
                        
                        Text("Faculty: Anthony Sullivan: 07/19/2019 -- 08/19/2019")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(6)
                    }
                }
            }
          
                
                
               
               
            VStack{
                Spacer().frame(height: 188)
                // when the download button is not clicked
                if Case.activeCase.id != ""{
                    NavigationLink{
                        CaseInfoView(curCase: Case.activeCase)
                            .environmentObject(Trainee.activeTrainee)
                    }label: {
                        Text("Current Case")
                            .font(.custom("Pacifico-Regular", size: 35))
                            .fontWeight(.bold)
                            .frame(maxWidth: 250)
                            .foregroundColor(.white)
                            .padding().cornerRadius(15)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [Color.blue, Color.green]
                                    ),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .cornerRadius(15)
                                   
                            )
                    }

                    Button{
                        trainee.caseID = ""
                        trainee.isAvailableForCase = true
                        Case.activeCase = Case()
                        upLoadTrainee(trainee)
                    } label: {
                        Text("Complete")
                            .font(.custom("Pacifico-Regular", size: 35))
                            .fontWeight(.bold)
                            .frame(maxWidth: 250)
                            .foregroundColor(.white)
                            .padding().cornerRadius(15)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [Color.yellow, Color.red]
                                    ),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .cornerRadius(15)
                                   
                            )
                    }
                    .padding(.horizontal)
                    
                }
                
                //Spacer()
                Spacer().frame(height: 50)
                       
                       
                }
            }
        }
    }
