//
//  IDInput.swift
//  FrontDesk
//
//  Created by Martin Zuo on 12/4/24.
//

import SwiftUI

struct IDInput: View {
    @EnvironmentObject var data: ScheduleData
    @State var selectedTrainee: Trainee = Trainee()
    
    @State var confirmed: Bool = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private func toggleSelection(_ traineeID: String, _ trainee: Trainee) {
        if selectedTrainee.traineeID != traineeID {
            confirmed = false
        }
        selectedTrainee = trainee
    }
    
    var body: some View {
        NavigationView{
            VStack {
                
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(data.traineeList, id: \.traineeID) { trainee in
                            TraineeRowView(
                                trainee: trainee,
                                isSelected: selectedTrainee.traineeID == trainee.traineeID,
                                toggleSelection: toggleSelection  // again, this line is from gpt
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                if selectedTrainee.traineeID != "" {
                    Button {
                        getTraineee(selectedTrainee.traineeID)
                        getCases(selectedTrainee.caseID)
                        getRelatedFaculties(selectedTrainee.caseID)
                        confirmed = true
                    } label: {
                        Text("Confirm")
                    }
                }
                
                if confirmed == true {
                    NavigationLink{
                        MainView().environmentObject(Trainee.activeTrainee)
                    }label: {
                        Text("Go to Main View")
                    }
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
                // MARK: END
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
    IDInput()
}
