//
//  FrontDeskApp.swift
//  FrontDesk
//
//  Created by DJY on 11/5/24.
//

import SwiftUI
import SwiftData

@main
struct FrontDeskApp: App {
    
    @StateObject var trainee = Trainee.defaultTrainee
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
            Entrance().environmentObject(trainee)
        }
        .modelContainer(sharedModelContainer)
    }
}
