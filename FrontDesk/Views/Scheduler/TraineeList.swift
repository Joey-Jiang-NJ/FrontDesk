//
//  TraineeList.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/25/24.
//

import SwiftUI

struct TraineeList: View {
    @EnvironmentObject var data: ScheduleData

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.teal.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                // Header
                Text("All Trainees")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)

                // Trainee List
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(data.traineeList, id: \.traineeID) { trainee in
                            NavigationLink(destination: TraineeView().environmentObject(trainee)) {
                                TraineeCardView(trainee: trainee)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove default NavigationLink styling
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
            if trainee.traineeID.lowercased() == "076eee0e-04bf-413a-8dc1-5a52ed8ee7b7" {
                Image("head")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.firstName == "Sarah" {
                Image("head1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.firstName == "Michael" {
                Image("head2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.firstName == "Emily" {
                Image("head3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
            } else if trainee.lastName == "Brown" {
                Image("head4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                    .frame(width: 80, height: 80)
            }
            else {
                Image(uiImage: imageFromString(trainee.picture))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
            }
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
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
        )
        .padding(.horizontal, 5)
    }
}

#Preview {
    TraineeList()
        .environmentObject(ScheduleData())
}

