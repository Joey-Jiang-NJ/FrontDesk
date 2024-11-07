
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
