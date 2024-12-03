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
    @State var curRotation: Rotation
    @State var pastRotations: [Rotation]
    
    var body: some View {
        ZStack {
                   // Background Image
                   Image("dukehealth")
                       .resizable()
                       .edgesIgnoringSafeArea(.all).opacity(0.62)
            VStack(alignment: .leading,spacing: 10) {
                HStack(spacing: 30){
                    VStack {
                        Image(uiImage: imageFromString(trainee.picture))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        Text("\(trainee.firstName) \(trainee.lastName)").font(.custom("LilyScriptOne-Regular", size: 20))
                        
                    }
                    Text("Rotations Summaries")
                        .font(.custom("LilyScriptOne-Regular", size: 30))
                }.padding()
                HStack{
                    Image(systemName: "clock.fill")
                        .foregroundStyle(Color.green)
                    Text("Active Rotation Summaries")
                        .font(.custom("LilyScriptOne-Regular", size: 25))
                }.padding()
                
                Grid {
                    GridRow {
                        Text("Rotation").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                        Spacer()
                        Text(curRotation.rotationName).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                    }
                    
                    GridRow {
                        Text("Director").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                        Spacer()
                        Text(curRotation.facultyName).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                    }
                    
                    GridRow {
                        Text("Start Date").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                        Spacer()
                        Text(curRotation.startDate).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                    }
                    
                    GridRow {
                        Text("End Date").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                        Spacer()
                        Text(curRotation.endDate).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                    }
                    Divider()
                }
                
                HStack{
                    Image(systemName: "book.fill")
                        .foregroundStyle(Color.brown)
                    Text("Past Rotation Summaries")
                        .font(.custom("LilyScriptOne-Regular", size: 30))
                }.padding()
                
                ScrollView {
                    Grid {
                        ForEach(pastRotations){ rotation in
                            GridRow {
                                Text("Rotation").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                                Spacer()
                                Text(rotation.rotationName).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                            }
                            
                            GridRow {
                                Text("Director").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                                Spacer()
                                Text(rotation.facultyName).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                            }
                            
                            GridRow {
                                Text("Start Date").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                                Spacer()
                                Text(rotation.startDate).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                            }
                            
                            GridRow {
                                Text("End Date").font(.custom("Orbitron-Bold", size: 15)).fontWeight(.bold)
                                Spacer()
                                Text(rotation.endDate).font(.custom("PlaywriteAUTAS-Regular", size: 15))
                            }
                            Divider()
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    let trainee = Trainee(
//        traineeID: "12345",
//        rotationID: "54321",
//        firstName: "John",
//        lastName: "Doe",
//        emailAddress: "john.doe@duke.edu")
//    
//    let rotation1 = Rotation(
//        id: "1",
//        rotationName: "Gynecologic Oncology",
//        facultyName: "Anthony Sullivan",
//        startDate: "07/19/2019",
//        endDate: "08/19/2019")
//    
//    let rotation2 = Rotation(
//        id: "2",
//        rotationName: "Labor and Delivery",
//        facultyName: "Anthony Sullivan",
//        startDate: "07/19/2019",
//        endDate: "08/19/2019")
//    
//    let rotation3 = Rotation(
//        id: "3",
//        rotationName: "Obstetrics",
//        facultyName: "Anthony Sullivan",
//        startDate: "07/19/2019",
//        endDate: "08/19/2019")
//    
//    let rotation4 = Rotation(
//        id: "3",
//        rotationName: "Pediatrics",
//        facultyName: "Anthony Sullivan",
//        startDate: "07/19/2019",
//        endDate: "08/19/2019")
//    
//    let rotation5 = Rotation(
//        id: "5",
//        rotationName: "Cardiology",
//        facultyName: "Anthony Sullivan",
//        startDate: "07/19/2019",
//        endDate: "08/19/2019")
//    
//    let pastRotations = [rotation2, rotation3, rotation4, rotation5]
//    
//    RotationHistoryView(curRotation: rotation1, pastRotations: pastRotations)
//        .environmentObject(trainee)
//}
