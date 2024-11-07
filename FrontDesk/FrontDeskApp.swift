<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> origin/Junyuan
//
//  FrontDeskApp.swift
//  FrontDesk
//
<<<<<<< HEAD
//  Created by Zhouyi Jiang on 10/24/24.
//
>>>>>>> origin/Zhouyi
=======
//  Created by DJY on 11/5/24.
//
>>>>>>> origin/Junyuan

import SwiftUI
import SwiftData

@main
struct FrontDeskApp: App {
<<<<<<< HEAD
    @StateObject private var trainee = Trainee()
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                ContentView().environmentObject(trainee)
            }
        }
=======
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
>>>>>>> origin/Junyuan
    }
}
