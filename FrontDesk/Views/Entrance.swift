//
//  Entrance.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/14.
//

import SwiftUI

struct Entrance: View {
    // MARK: we learned navigation stack from chatgpt to avoid double back buttons
    @State private var navigationPath = NavigationPath()
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // add the background page
                
                Image("bg2")
                    .resizable()
                    .ignoresSafeArea()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.625), Color.black.opacity(0.314)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                //add some space here to make the page clearer
                VStack(spacing: 30) {
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()

                    Text("Welcome to FrontDesk")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.756), radius: 11)
                    
                    
                    Text("Choose your role to proceed")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.799))
                        .shadow(color: Color.black.opacity(0.756), radius: 11)
                    //Add the trainee button
                    Button(action: {
                        // add the animation to let user know which button they click
                        withAnimation(.easeInOut) {
                            navigationPath.append("Trainee")
                        }
                    }) {
                        HStack {
                            // add the trainee button first
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                            Text("Trainee")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        // make the corner round
                        .cornerRadius(12)
                        .shadow(color: Color.blue.opacity(0.5), radius: 11)
                    }
                    //similar to trainee, add the Faculty button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            navigationPath.append("Faculty")
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.2")
                                .font(.title2)
                            Text("Faculty")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.teal]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.green.opacity(0.5), radius: 11)
                    }
                    // add the scheduler button next
                    Button(action: {
                        withAnimation(.easeInOut) {
                            navigationPath.append("Scheduler")
                        }
                    }) {
                        HStack {
                            Image(systemName: "calendar.and.person")
                                .font(.title2)
                            Text("Scheduler")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .frame(width: 150)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.black]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.green.opacity(0.5), radius: 11)
                    }
                }
             
                .toolbar {
                    // put the FrontDesk in the center of the FrontDesk
                    ToolbarItem(placement: .principal) {
                        Text("FrontDesk")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .padding()
                    }
                }
            }
            //MARK: This part is also learned from gpt (part of the navigation stack)
            .navigationDestination(for: String.self) { destination in
                            if destination == "Trainee" {
                                IDInput()
                                    .environmentObject(ScheduleData.data)
//                                MainView()
//                                    .environmentObject(Trainee.activeTrainee) // Pass environment object for MainView
                            } else if destination == "Faculty" {
                                IDInput_faculty()
                                    .environmentObject(ScheduleData.data)
                            }
                            else if destination == "Scheduler" {
                                SchedulerMain()
                                .environmentObject(ScheduleData.data)
                            }
                }
            .onAppear {
//                getAllTrainees()
//                getAllFaculties()
//                getAllCases()
                // MARK: This Error Handler comes from chatGpt
                getAllTrainees { error in
                    self.handleNetworkError(error)
                }
                getAllFaculties { error in
                    self.handleNetworkError(error)
                }
                getAllCases { error in
                    self.handleNetworkError(error)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("network error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("yes"))
                )
            }
            // MARK: END
        }
    }
    
    // Function to handle network errors
    // MARK: This Error Handler comes from chatGpt
    private func handleNetworkError(_ error: Error) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                self.alertMessage = "No network connection, please check your network settings。"
            case .timedOut:
                self.alertMessage = "Request timed out, please try again later."
            default:
                self.alertMessage = "Could not connect to the server, please try again later."
            }
        } else {
            self.alertMessage = "An unknown error has occurred：\(error.localizedDescription)"
        }
        self.showAlert = true
    }
    // MARK: END
}


#Preview {
    Entrance()
}
