import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Today", systemImage: "calendar")
            }

            NavigationStack {
                PhrasebookView()
            }
            .tabItem {
                Label("Phrases", systemImage: "text.book.closed")
            }

            NavigationStack {
                ReviewView()
            }
            .tabItem {
                Label("Review", systemImage: "rectangle.stack")
            }

            NavigationStack {
                ScenarioView()
            }
            .tabItem {
                Label("Practice", systemImage: "person.2.wave.2")
            }

            NavigationStack {
                ListeningView()
            }
            .tabItem {
                Label("Listen", systemImage: "headphones")
            }
        }
        .tint(.italiaGreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ReviewStore(inMemory: true))
            .environmentObject(SpeechPlayer())
    }
}
