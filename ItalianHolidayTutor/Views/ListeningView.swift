import SwiftUI

struct ListeningView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                missionCard

                ForEach(LearningData.listeningResources) { resource in
                    resourceCard(resource)
                }
            }
            .padding(18)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Listen")
    }

    private var missionCard: some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 12) {
                Label("Real-world input", systemImage: "antenna.radiowaves.left.and.right")
                    .font(.headline)
                    .foregroundStyle(.italiaGreen)

                Text("Use learner audio first, then native news. The goal is not perfect understanding: listen for recurring words, numbers, places, and chunks you already know.")
                    .font(.subheadline)
                    .foregroundStyle(.mutedInk)
                    .fixedSize(horizontal: false, vertical: true)

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "1.circle.fill")
                        .foregroundStyle(.signalBlue)
                    Text("Before: choose three words to listen for.")
                        .font(.subheadline)
                }

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "2.circle.fill")
                        .foregroundStyle(.sunset)
                    Text("During: tally each word or phrase you catch.")
                        .font(.subheadline)
                }

                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "3.circle.fill")
                        .foregroundStyle(.tomato)
                    Text("After: retell the topic in one English sentence and one Italian phrase.")
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.ink)
        }
    }

    private func resourceCard(_ resource: ListeningResource) -> some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: resource.systemImage)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 38, height: 38)
                        .background(Color.signalBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                    VStack(alignment: .leading, spacing: 5) {
                        Text(resource.title)
                            .font(.headline)
                            .foregroundStyle(.ink)

                        Text("\(resource.level) · \(resource.cadence)")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.signalBlue)
                    }

                    Spacer()
                }

                Text(resource.whyItHelps)
                    .font(.subheadline)
                    .foregroundStyle(.mutedInk)
                    .fixedSize(horizontal: false, vertical: true)

                Divider()

                Label(resource.mission, systemImage: "scope")
                    .font(.subheadline)
                    .foregroundStyle(.ink)
                    .fixedSize(horizontal: false, vertical: true)

                if let url = URL(string: resource.url) {
                    Link(destination: url) {
                        Label("Open source", systemImage: "arrow.up.right")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.signalBlue)
                }
            }
        }
    }
}

struct ListeningView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListeningView()
        }
    }
}
