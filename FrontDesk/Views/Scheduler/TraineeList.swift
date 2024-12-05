//
//  TraineeList.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/15/24.
//

import SwiftUI

struct TraineeList: View {
    @EnvironmentObject var data: ScheduleData

    var body: some View {
        ZStack {
            // background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // header
                Text("All Trainees")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .shadow(color: .black.opacity(0.3), radius: 5)

                //add the information of each trainee
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(data.traineeList, id: \.traineeID) { trainee in
                            NavigationLink(destination: TraineeView().environmentObject(trainee)) {
                                TraineeCardView(trainee: trainee)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 10)
            }
        }
    }
}

struct TraineeCardView: View {
    let trainee: Trainee

    var body: some View {
        HStack(spacing: 15) {
            // Trainee Image
            
            Image(uiImage: imageFromString(trainee.picture))
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white))
                .shadow(radius: 3)
//                Image(uiImage: imageFromString(trainee.picture))
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50, height: 50)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                    .shadow(radius: 3)
          

            // Trainee Details
            VStack(alignment: .leading, spacing: 5) {
                Text("\(trainee.firstName) \(trainee.lastName)")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("ID: \(trainee.traineeID)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // show the state of the current trainee
                if trainee.isAvailableForCase {
                    Text("Available")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                } else {
                    Text("Not Available")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.9))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
        .padding(.horizontal, 5)
    }
}

//#Preview {
//    TraineeList()
//        .environmentObject(ScheduleData())
//}

