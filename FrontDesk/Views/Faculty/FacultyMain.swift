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
                  
                    Image("bg3")
                        .resizable()
                        //.scaledToFill()
                        .ignoresSafeArea()
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0.2)]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                   

                    VStack {
                        Image("symbol2").resizable().ignoresSafeArea().frame( maxWidth: .infinity,maxHeight: 400)
                   Spacer()
                      
                        
                        NavigationLink(destination: FacultyPersonInfo().environmentObject(faculty)) {
                            ButtonContent(label: "Person Info", icon: "person.crop.circle", colors: [Color.blue, Color.cyan])
                        }
                       

//                        NavigationLink(destination: Evaluation()) {
//                            ButtonContent(label: "Faculty Evaluation", icon: "doc.text.magnifyingglass", colors: [Color.green, Color.teal])
//                        }
                        NavigationLink(destination: TraineeListF().environmentObject(faculty)) {
                                               ButtonContent(label: "Trainee Info", icon: "person.2.crop.square.stack", colors: [Color.orange, Color.red])
                                           }

                        Spacer()
                    }
                    .padding()
                    .navigationTitle("")
                    .toolbar {
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
                                .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 4)
                        }
                    }
                }
            }
            .onAppear{
                var trainees: [Trainee_] = []
                let group = DispatchGroup()
                group.enter()
                fetchData(from: "http://localhost:8080/trainees") { (result: Result<[Trainee_], Error>) in
                    DispatchQueue.main.async{
                        switch result {
                        case .success(let data):
                            trainees = data
                            Faculty.defaultFaculty.relatedTrainees = []
                            for t in trainees{
                                if t.caseID != nil{
                                    print(t.caseID!.uuidString, Faculty.defaultFaculty.caseID)
                                }
                                if t.caseID != nil && t.caseID!.uuidString.lowercased() == Faculty.defaultFaculty.caseID.lowercased(){
                                    Faculty.defaultFaculty.relatedTrainees.append(traineeTrans(t))
                                }
                            }
                        case .failure(let error):
                            print("Error fetching cases:", error)
                        }
                        group.leave()
                    }
                }
                var faculties: [Faculty_] = []
                group.enter()
                fetchData(from: "http://localhost:8080/faculties") { (result: Result<[Faculty_], Error>) in
                    DispatchQueue.main.async{
                        switch result {
                        case .success(let data):
                            faculties = data
                            for f in faculties{
                                if f.id!.uuidString.lowercased() == Faculty.defaultFaculty.id.lowercased(){
                                    if f.preferences != nil{
                                        Faculty.defaultFaculty.preferences = f.preferences!
                                    }
                                }
                            }
                        case .failure(let error):
                            print("Error fetching cases:", error)
                        }
                        group.leave()
                    }
                }
            }
        }
    }

    struct ButtonContent: View {
        let label: String
        let icon: String
        let colors: [Color]

        var body: some View {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                Text(label)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(12)
            .shadow(color: colors.first?.opacity(0.5) ?? Color.black, radius: 10, x: 0, y: 4)
        }
    }


//#Preview {
//    FacultyMain()
//}
