//
//  RotationHistory.swift
//  FrontDesk
//
//  Created by 左中铭 on 2024/11/6.
//

import SwiftUI

struct RotationHistoryView: View {
    @EnvironmentObject var trainee: Trainee
    var image: UIImage {imageFromString(trainee.picture)}
        
    var body: some View {
        VStack(alignment: .leading,spacing: 10) {
            HStack(spacing: 30){
                VStack {
                    Image(uiImage: imageFromString(trainee.picture))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    Text("\(trainee.firstName) \(trainee.lastName)")
                    
                }
                Text("Rotations Summaries")
                    .font(.system(size: 40, weight: .bold, design: .default))
            }.padding()
            HStack{
                Image(systemName: "clock.fill")
                    .foregroundStyle(Color.green)
                Text("Active Rotation Summaries")
                    .font(.system(size: 20, weight: .bold, design: .default))
            }.padding()
            
            HStack{
                Image(systemName: "book.fill")
                    .foregroundStyle(Color.brown)
                Text("Past Rotation Summaries")
                    .font(.system(size: 20, weight: .bold, design: .default))
            }.padding()
            
            
        }
        
    }
}

#Preview {
    let trainee = Trainee(
        traineeID: "12345",
        rotationID: "54321",
        firstName: "Frodo",
        lastName: "Baggins",
        emailAddress: "frodo.baggins@duke.edu")
    RotationHistoryView().environmentObject(trainee)
}
