//
//  FacultyMain.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI
    
    struct FacultyMain: View {
        @EnvironmentObject var faculty: Faculty
        var body: some View {
            NavigationView {
                ZStack {
                  // add the background image
                    Image("bg3")
                        .resizable()
                        .ignoresSafeArea()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.618), Color.black.opacity(0.214)]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                   
                    // add the symbol in the main page
                    VStack {
                        Image("symbol2").resizable().ignoresSafeArea().frame( maxWidth: .infinity,maxHeight: 400)
                   Spacer()
                      
                        
                        NavigationLink(destination: FacultyPersonInfo().environmentObject(faculty)) {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .font(.title2)
                                Text("Person Info")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient( colors: [Color.blue, Color.black]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            // write corner radius to make the button round
                            .cornerRadius(15)
                           // ButtonContent(label: "Person Info", icon: "person.crop.circle", colors: [Color.blue, Color.black])
                        }
                       

//                        NavigationLink(destination: Evaluation()) {
//                            ButtonContent(label: "Faculty Evaluation", icon: "doc.text.magnifyingglass", colors: [Color.green, Color.teal])
//                        }
                        NavigationLink(destination: TraineeListF().environmentObject(faculty)) {
                            HStack {
                                Image(systemName: "person.2.crop.square.stack")
                                    .font(.title2)
                                Text("Trainee Info")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient( colors: [Color.red, Color.cyan]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
                        }

                        Spacer()
                    }
                    .padding()
                    .toolbar {
                        // again, put the title in the center of the tool bar
                        ToolbarItem(placement: .principal) {
                            Text("Faculty Main")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.blue]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: Color.black.opacity(0.5), radius: 10)
                        }
                    }
                }
            }
        }
    }

//    struct ButtonContent: View {
//        let label: String
//        let icon: String
//        let colors: [Color]
//
//        var body: some View {
//            HStack {
//                Image(systemName: icon)
//                    .font(.title2)
//                Text(label)
//                    .font(.title2)
//                    .fontWeight(.bold)
//            }
//            .foregroundColor(.white)
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: colors),
//                    startPoint: .leading,
//                    endPoint: .trailing
//                )
//            )
//            .cornerRadius(12)
//        }
//    }


//#Preview {
//    FacultyMain()
//}
