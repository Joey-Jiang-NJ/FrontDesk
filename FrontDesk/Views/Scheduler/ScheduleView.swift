//
//  ScheduleView.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/15/24.
//

import SwiftUI

struct SchedulerView: View {
    @ObservedObject var curCase: Case
    @EnvironmentObject var data: ScheduleData
    var vacantTrainees: [Trainee] {
        data.traineeList.filter {
            $0.isAvailableForCase == true
        }
    }
    @State var selectedTraineeIDs: Set<String> = []
    @State var selectedTrainees: [Trainee] = []
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                // Case Header
                CaseView(curCase: curCase)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                    )
                    .padding(.horizontal)

                // Trainee Section Header
                Text("Available Trainees")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                // Trainee List
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(vacantTrainees.sorted(by: {$0.evalScore > $1.evalScore}), id: \.traineeID) { trainee in
                            // show all the trainee who is available
                            if trainee.isAvailableForCase {
                                TraineeRowView(
                                    trainee: trainee,
                                    isSelected: selectedTraineeIDs.contains(trainee.traineeID),
                                    toggleSelection: toggleSelection
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Save Button
                Button {
                    // here, we upload the information to the server
                    for t in selectedTrainees {
                        t.isAvailableForCase = false
                        t.caseID = curCase.id
                    }
                    for t in selectedTrainees {
                        upLoadTrainee(t)
                    }
                    
                    // MARK: This Error Handler comes from chatGpt
//                    getAllTrainees()
                    getAllTrainees { error in
                        self.handleNetworkError(error)
                    }
                    // MARK: END
                    
                    for t in selectedTrainees {
                        t.isAvailableForCase = false
                        t.caseID = curCase.id
                    }
                    for t in selectedTrainees {
                        upLoadTrainee(t)
                    }
                    
//                    getAllTrainees()
                    // MARK: This Error Handler comes from chatGpt
                    getAllTrainees { error in
                        self.handleNetworkError(error)
                    }
                    // MARK: END
                    
                } label: {
                    Text("Save Selection")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange, Color.red]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                        .shadow(color: Color.orange.opacity(0.4), radius: 5)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitle("Select Trainee", displayMode: .inline)
    }
    //MARK: We ask Chatgpt about this func
    private func toggleSelection(_ traineeID: String, _ trainee: Trainee) {
        if selectedTraineeIDs.contains(traineeID) {
            selectedTraineeIDs.remove(traineeID)
            selectedTrainees.removeAll(where: { $0.traineeID == traineeID })
        } else {
            selectedTraineeIDs.insert(traineeID)
            selectedTrainees.append(trainee)
        }
    }
    //MARK: END
    
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

struct TraineeRowView: View {
    let trainee: Trainee
    let isSelected: Bool
    let toggleSelection: (String, Trainee) -> Void

    var body: some View {
        HStack {
            if !trainee.picture.isEmpty {
                Image(uiImage: imageFromString(trainee.picture))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray))
            } else {
                Image("Elaina")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(trainee.firstName) \(trainee.lastName)")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("ID: \(trainee.traineeID)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color.blue.opacity(0.2) : Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
        //MARK: From GPT
        .onTapGesture {
            toggleSelection(trainee.traineeID, trainee)
        }
        //MARK: END
    }
}

//#Preview {
//    SchedulerView(curCase: Case.dafaultCase)
//        .environmentObject(ScheduleData())
//}
