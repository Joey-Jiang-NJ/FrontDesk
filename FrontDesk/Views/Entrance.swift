//
//  Entrance.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/14.
//

import SwiftUI

struct Entrance: View {
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                // Background with gradient overlay
                Image("bg2")
                    .resizable()
                    //.scaledToFill()
                    .ignoresSafeArea()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0.3)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )

                VStack(spacing: 20) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 20)

                    Text("Welcome to FrontDesk")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 4)

                    Text("Choose your role to proceed")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 40)

                    Button(action: {
                        withAnimation(.easeInOut) {
                            navigationPath.append("Trainee")
                        }
                    }) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.title2)
                            Text("Trainee")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: 150)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.blue.opacity(0.5), radius: 8, x: 0, y: 4)
                    }

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
                        .frame(maxWidth: 150)
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
                        .shadow(color: Color.green.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
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
                        .frame(maxWidth: 150)
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
                        .shadow(color: Color.green.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                }
                .navigationTitle("")
                .toolbar {
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
            .navigationDestination(for: String.self) { destination in
                            if destination == "Trainee" {
                                MainView()
                                    .environmentObject(Trainee.defaultTrainee) // Pass environment object for MainView
                            } else if destination == "Faculty" {
                                FacultyMain()
                                    .environmentObject(Faculty.defaultFaculty)
                            }
                            else if destination == "Scheduler" {
                                    SchedulerMain()
                            }
                }
        }
    }
}


#Preview {
    Entrance()
}
