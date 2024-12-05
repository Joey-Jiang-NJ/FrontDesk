//
//  FrontDeskApp.swift
//  FrontDesk
//
//  Created by DJY on 11/5/24.
//

import SwiftUI

@main
struct FrontDeskApp: App {
    var body: some Scene {
        WindowGroup {
            Entrance()
            .onAppear {
//                _ = Trainee.activeTrainee.loadFromArch()
                _ = Trainee.activeTrainee.loadFromArchCL()
            }
        }
    }
}
