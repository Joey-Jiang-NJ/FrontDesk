<<<<<<< HEAD
=======
//
//  FrontDeskApp.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 10/24/24.
//
>>>>>>> origin/Zhouyi

import SwiftUI
import SwiftData

@main
struct FrontDeskApp: App {
    @StateObject private var trainee = Trainee()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView().environmentObject(trainee)
            }
        }
    }
}
