//
//  ContentView.swift
//  FrontDesk
//
//  Created by DJY on 10/25/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    var body: some View {
        NavigationView {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Main", systemImage: "house")
                    }
                CaseLogListView()
                    .tabItem {
                        Label("Case Logs", systemImage: "list.bullet")
                    }
                PersonInfoView()
                    .tabItem {
                        Label("Person Info", systemImage: "person.crop.circle")
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Front Desk")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image("Elaina")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                }
            }
           
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        ZStack{
            Image("dukehealth").resizable().ignoresSafeArea().opacity(0.6)
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Ongoing Rotations Section
                    Text("Ongoing rotations")
                        .font(.title)
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
                        // learn navigationlink from gpt
                        NavigationLink(destination: RotationDetailView()) {
                            HStack {
                                Text("Rotation1")
                                    .font(.subheadline)
                                    .fontWeight(.heavy)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                        }
                        
                        Text("Faculty: James\nTime: 12/01/2022 -- 11/20/2023")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                }
            }
          
                
                
               
               
            VStack{
                Spacer().frame(height: 200)
                Button(action: {
                    // action to the case log
                }) {
                    Text("Current Case")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding().background(Color.red).cornerRadius(12)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [Color.orange, Color.pink]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(12)
                               
                        )
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.green,
                                        Color.purple.opacity(0.3)
                                    ]
                                ),
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                            .cornerRadius(12)
                        )
                        .cornerRadius(12)
                        
                }
                //Spacer()
                Spacer().frame(height: 50)
                Button(action: {
                    // action to the protocol
                }) {
                    Text("Protocol")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding().background(Color.red).cornerRadius(30)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [Color.orange, Color.pink]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(12)
                               
                        )
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.blue,
                                        Color.purple.opacity(0.3)
                                    ]
                                ),
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                            .cornerRadius(12)
                        )
                       
                       
                }
            }
        }
    }
    

    
}

struct RotationDetailView: View {
    var body: some View {
        VStack {
            Text("Rotation Details")
                .font(.largeTitle)
                .padding()
            
            Text("Detailed information about the selected rotation.")
                .padding()
            
            Spacer()
        }
        .navigationTitle("Rotation Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// Personal Info View
struct PersonInfoView: View {
    var body: some View {
        VStack {
            Text("Personal Information")
                .font(.largeTitle)
                .padding()
           
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Item.self, inMemory: true)
}
