import SwiftUI

@main
struct DemoApp: App {
    @StateObject var model = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {           
            ContentView()
                .environmentObject(model)
        }
    }
}
