//
//  CurCases.swift
//  FrontDesk
//
//  Created by Martin Zuo on 11/15/24.
//

import SwiftUI


struct CurCases: View {
    @EnvironmentObject var data: ScheduleData

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    // Custom Header Title
                    Text("Active Cases")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                        .shadow(color: Color.black.opacity(0.2), radius: 5)

                    // Case List
                    // show all the cases for scheduler to select
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(data.caseList, id: \.id) { case_ in
                                NavigationLink(destination: SchedulerView(curCase: case_).environmentObject(data)) {
                                    VStack(alignment: .leading, spacing: 8) {
                                        // Case Type
                                        Text(case_.type)
                                            .font(.headline)
                                            .foregroundColor(.primary)

                                        // Diagnosis
                                        Text("Diagnosis: \(case_.diagnosis)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white)
                                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            // hode the navigationbar
            .navigationBarHidden(true)
        }
    }
}

#Preview {
   
   CurCases()
     
}

