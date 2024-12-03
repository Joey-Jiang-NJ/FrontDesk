//
//  SchedulerMain.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/25/24.
//

import SwiftUI

struct SchedulerMain: View {
    @StateObject var data = ScheduleData()
    var body: some View {
        TabView {
            CurCases()
                .environmentObject(data)
                .tabItem {
                    Label("Cases", systemImage: "house")
                }.onAppear{
                    var trainees: [Trainee_] = []
                    let group = DispatchGroup()
                    group.enter()
                    fetchData(from: "http://localhost:8080/trainees") { (result: Result<[Trainee_], Error>) in
                        DispatchQueue.main.async{
                            switch result {
                            case .success(let data):
                                trainees = data
                                self.data.traineeList = []
                                for t in trainees{
                                    self.data.traineeList.append(traineeTrans(t))
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
                                self.data.faclutyList = []
                                for f in faculties{
                                    self.data.faclutyList.append(facultyTrans(f))
                                }
                            case .failure(let error):
                                print("Error fetching cases:", error)
                            }
                            group.leave()
                        }
                    }
                    var cases: [Case_] = []
                    group.enter()
                    fetchData(from: "http://localhost:8080/cases") { (result: Result<[Case_], Error>) in
                        DispatchQueue.main.async{
                            switch result {
                            case .success(let data):
                                cases = data
                                self.data.caseList = []
                                for c in cases{
                                    self.data.caseList.append(caseTrans(c))
                                }
                            case .failure(let error):
                                print("Error fetching cases:", error)
                            }
                            group.leave()
                        }
                    }
                }

            TraineeList()
                .environmentObject(data)
                .tabItem {
                    Label("Trainees", systemImage: "list.bullet.clipboard")
                }
        }
    }
}

#Preview {
    SchedulerMain()
}
