//
//  SchedulerMain.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/25/24.
//

import SwiftUI

struct SchedulerMain: View {
    @EnvironmentObject var data: ScheduleData
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        TabView {
            // use tab view here for scheduler to select trainee and case
            CurCases()
                .environmentObject(data)
                .tabItem {
                    Label("Cases", systemImage: "house")
                }.onAppear{
                    //                    getAllTrainees()
                    //                    getAllFaculties()
                    //                    getAllCases()
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
                    // MARK: END
                }
            TraineeList()
                .environmentObject(data)
                .tabItem {
                    Label("Trainees", systemImage: "list.bullet.clipboard")
                }
        }
    }
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
    SchedulerMain()
}
