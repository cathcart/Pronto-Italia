import SwiftUI

@main
struct ItalianHolidayTutorApp: App {
    @StateObject private var reviewStore = ReviewStore()
    @StateObject private var speechPlayer = SpeechPlayer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reviewStore)
                .environmentObject(speechPlayer)
        }
    }
}
