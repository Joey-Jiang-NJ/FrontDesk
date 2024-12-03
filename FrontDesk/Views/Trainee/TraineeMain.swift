//
//  ContentView.swift
//  FrontDesk
//
//  Created by DJY on 10/25/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var trainee: Trainee
    @State var image: UIImage? = UIImage()
    var body: some View {
        NavigationView {
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
           
        }
        .onAppear{
            let group = DispatchGroup()
            var trainees: [Trainee_] = []
            group.enter()
            fetchData(from: "http://localhost:8080/trainees") { (result: Result<[Trainee_], Error>) in
                DispatchQueue.main.async{
                    switch result {
                    case .success(let data):
                        trainees = data
                        for t in trainees{
                            if t.caseID != nil && Trainee.defaultTrainee.traineeID.lowercased() == t.id!.uuidString.lowercased(){
                                Trainee.defaultTrainee.caseID = t.caseID!.uuidString
                                break
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

struct ContentView: View {
    @State var flag: Bool = false
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
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
                        // learn navigationlink from gpt
                        NavigationLink(destination: RotationHistoryView(curRotation: Rotation.defaultCurRotation, pastRotations: Rotation.defaultPastRotations).environmentObject(Trainee.defaultTrainee)) {
                            HStack {
                                Text("Rotation3")
                                    .font(.subheadline)
                                    .fontWeight(.heavy)
                                Spacer()
                              
                            }
                            .padding()
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
                Spacer().frame(height: 200)
                if flag == false{
                    Text("You have no case now.")
                        .font(.custom("Pacifico-Regular", size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding().cornerRadius(12)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [Color.blue, Color.green]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(12)
                               
                        )
                }else{
                    NavigationLink{
                        CaseInfoView(curCase: Case.defaultCase)
                            .environmentObject(Trainee.defaultTrainee)
                    }label: {
                        Text("Current Case")
                            .font(.custom("Pacifico-Regular", size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding().cornerRadius(12)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [Color.blue, Color.green]
                                    ),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                .cornerRadius(12)
                                   
                            )
    //s                        .cornerRadius(12)
                            
                    }
                }
                
                //Spacer()
                Spacer().frame(height: 50)
                Button(action: {
                    // action to the protocol
                    let group = DispatchGroup()
                    var cases: [Case_] = []
                    group.enter()
                    fetchData(from: "http://localhost:8080/cases") { (result: Result<[Case_], Error>) in
                        DispatchQueue.main.async{
                            switch result {
                            case .success(let data):
                                cases = data
                                for c in cases{
                                    if c.id!.uuidString.lowercased() == Trainee.defaultTrainee.caseID.lowercased(){
                                        let tmp = caseTrans(c)
                                        Case.defaultCase.id = tmp.id
                                        Case.defaultCase.type = tmp.type
                                        Case.defaultCase.diagnosis = tmp.diagnosis
                                        Case.defaultCase.symptoms = tmp.symptoms
                                        print(Case.defaultCase.id)
                                        break
                                    }
                                }
                            case .failure(let error):
                                print("Error fetching cases:", error)
                            }
                            group.leave()
                        }
                    }
                    flag = true
                    var faculties: [Faculty_] = []
                    group.enter()
                    fetchData(from: "http://localhost:8080/faculties") { (result: Result<[Faculty_], Error>) in
                        DispatchQueue.main.async{
                            switch result {
                            case .success(let data):
                                faculties = data
                                Trainee.defaultTrainee.relatedFaculties = []
                                for f in faculties{
                                    if f.caseID != nil{
                                        print(f.caseID!.uuidString, Faculty.defaultFaculty.caseID)
                                    }
                                    if f.caseID != nil && f.caseID!.uuidString.lowercased() == Faculty.defaultFaculty.caseID.lowercased(){
                                        Trainee.defaultTrainee.relatedFaculties.append(facultyTrans(f))
                                    }
                                }
                            case .failure(let error):
                                print("Error fetching cases:", error)
                            }
                            group.leave()
                        }
                    }
                }) {
                    Text("Download")
                        .font(.custom("Pacifico-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding().background(Color.red).cornerRadius(30)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [Color.green, Color.blue]
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .cornerRadius(12)
                               
                        )
//                        .overlay(
//                            LinearGradient(
//                                gradient: Gradient(
//                                    colors: [
//                                        Color.blue,
//                                        Color.green.opacity(0.3)
//                                    ]
//                                ),
//                                startPoint: .bottomLeading,
//                                endPoint: .topTrailing
//                            )
//                            .cornerRadius(12)
//                        )
                       
                       
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
//struct PersonInfoView: View {
//    var body: some View {
//        VStack {
//            Text("Personal Information")
//                .font(.largeTitle)
//                .padding()
//           
//        }
//    }
//}

//#Preview {
//    let trainee = Trainee(
//        traineeID: "12345",
//        rotationID: "54321",
//        firstName: "John",
//        lastName: "Doe",
//        emailAddress: "john.doe@duke.edu"
//   
//        )
//    MainView()
//        .environmentObject(trainee)
//        .modelContainer(for: Item.self, inMemory: true)
//}
