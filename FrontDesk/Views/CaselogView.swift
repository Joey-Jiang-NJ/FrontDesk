//
//  CaselogView.swift
//  FrontDesk
//
//  Created by DJY on 11/5/24.
//

import SwiftUI
import SwiftData

struct CaseLog: Identifiable {
    let id = UUID()
    let title: String
    let date: Date
    let description: String
}

struct CaseLogListView: View {
   
    let caseLogs = [
        CaseLog(title: "Case 1", date: Date(), description: "Description of Case 1"),
        CaseLog(title: "Case 2", date: Date(), description: "Description of Case 2"),
        CaseLog(title: "Case 3", date: Date(), description: "Description of Case 3")
    ]

    var body: some View {
        NavigationView {
            List(caseLogs) { caseLog in NavigationLink(destination: CaseDetailView(caseLog: caseLog)) {
                    VStack(alignment: .leading) {
                        Text(caseLog.title).font(.headline)
                        // ask gpt about bug here (style: .date)
                        Text(caseLog.date, style: .date).font(.subheadline).foregroundColor(.secondary)
                    }
                }
            }
           
            .navigationTitle("Case Logs")
        }
       
        
    }
}

struct CaseDetailView: View {
    @State private var isShowingProtocol = false
    let caseLog: CaseLog

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(caseLog.title).font(.largeTitle).fontWeight(.bold)
            
            Text(caseLog.date, style: .date).font(.subheadline).foregroundColor(.secondary)

            Text(caseLog.description).font(.body).padding(.top)

            Spacer()
            Button(action: {
                isShowingProtocol = true
            }) {
                Text("Self_reflection").font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                    .padding().background(Color.orange).cornerRadius(15)
                   
                   
            }
            .sheet(isPresented: $isShowingProtocol) {
                SelfReflectionView()
            }
        }
        .padding()
        .navigationTitle("Case Details")
    }
}
