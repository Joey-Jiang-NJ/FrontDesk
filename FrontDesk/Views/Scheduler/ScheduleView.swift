//
//  ScheduleView.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/25/24.
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
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
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
                        ForEach(vacantTrainees, id: \.traineeID) { trainee in
                            TraineeRowView(
                                trainee: trainee,
                                isSelected: selectedTraineeIDs.contains(trainee.traineeID),
                                toggleSelection: toggleSelection
                            )
                        }
                    }
                    .padding(.horizontal)
                }

                // Save Button
                Button {
                    // TODO: Upload to server
                    for t in selectedTrainees {
                        t.isAvailableForCase = false
                        t.caseID = curCase.id
                        let t_: Trainee_ = traineeTrans2(t)
                        updateCaseLog(serverURL: "http://localhost:8080/", trainee: t_) { result in
                            switch result {
                            case .success(let response):
                                print("Update succeeded with status code: \(response.statusCode)")
                            case .failure(let error):
                                print("Update failed: \(error.localizedDescription)")
                            }
                        }
                    }
                    
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
                        .shadow(color: Color.orange.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitle("Select Trainee", displayMode: .inline)
    }

    private func toggleSelection(_ traineeID: String, _ trainee: Trainee) {
        if selectedTraineeIDs.contains(traineeID) {
            selectedTraineeIDs.remove(traineeID)
            selectedTrainees.removeAll(where: { $0.traineeID == traineeID })
        } else {
            selectedTraineeIDs.insert(traineeID)
            selectedTrainees.append(trainee)
        }
    }
}

struct TraineeRowView: View {
    let trainee: Trainee
    let isSelected: Bool
    let toggleSelection: (String, Trainee) -> Void

    var body: some View {
        HStack {
            if trainee.traineeID.lowercased() == "076eee0e-04bf-413a-8dc1-5a52ed8ee7b7" {
                Image("head")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.firstName == "Sarah" {
                Image("head1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 3)
                    .frame(width: 80, height: 80)
            } else if trainee.firstName == "Michael" {
                Image("head2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.firstName == "Emily" {
                Image("head3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.lastName == "Brown" {
                Image("head4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 3)
            } else {
                Image(uiImage: imageFromString(trainee.picture))
                                   .resizable()
                                   .scaledToFill()
                                   .frame(width: 50, height: 50)
                                   .clipShape(Circle())
                                   .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                   .shadow(radius: 3)
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
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .onTapGesture {
            toggleSelection(trainee.traineeID, trainee)
        }
    }
}

//#Preview {
//    SchedulerView(curCase: Case.dafaultCase)
//        .environmentObject(ScheduleData())
//}
