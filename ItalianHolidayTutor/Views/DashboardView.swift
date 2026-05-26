import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var reviewStore: ReviewStore

    private var dueCount: Int {
        reviewStore.duePhrases(from: LearningData.phrases).count
    }

    private var masteredCount: Int {
        reviewStore.masteredCount(from: LearningData.phrases)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                hero
                metrics
                dailyPlan
                holidayPacks
            }
            .padding(18)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Pronto Italia")
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Holiday Italian that sticks")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.ink)
                        .lineLimit(2)

                    Text("Recognise the words you will actually hear: trains, menus, money, hotels, directions, and quick rescue phrases.")
                        .font(.subheadline)
                        .foregroundStyle(.mutedInk)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                Image(systemName: "figure.walk.motion")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 58, height: 58)
                    .background(Color.italiaGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }

            NavigationLink {
                ReviewView()
            } label: {
                Label("Start today's review", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.italiaGreen)
        }
        .padding(18)
        .background(
            LinearGradient(
                colors: [.white, .italiaGreen.opacity(0.12), .signalBlue.opacity(0.10)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var metrics: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            MetricTile(title: "Due today", value: "\(dueCount)", systemImage: "clock.badge.checkmark", tint: .tomato)
            MetricTile(title: "Mastered", value: "\(masteredCount)", systemImage: "checkmark.seal.fill", tint: .italiaGreen)
            MetricTile(title: "Phrases", value: "\(LearningData.phrases.count)", systemImage: "textformat.abc", tint: .signalBlue)
        }
    }

    private var dailyPlan: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("15-minute learning loop")
                .font(.title3.bold())
                .foregroundStyle(.ink)

            ForEach(LearningData.dailyPlan) { step in
                CardSurface {
                    HStack(alignment: .top, spacing: 14) {
                        Image(systemName: step.systemImage)
                            .font(.headline)
                            .foregroundStyle(step.tint)
                            .frame(width: 34, height: 34)
                            .background(step.tint.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(step.title)
                                    .font(.headline)
                                    .foregroundStyle(.ink)

                                Spacer()

                                Text("\(step.minutes)m")
                                    .font(.caption.weight(.bold))
                                    .foregroundStyle(step.tint)
                            }

                            Text(step.method)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(step.tint)

                            Text(step.instruction)
                                .font(.subheadline)
                                .foregroundStyle(.mutedInk)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }
    }

    private var holidayPacks: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Holiday packs")
                .font(.title3.bold())
                .foregroundStyle(.ink)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(PhraseCategory.allCases) { category in
                    NavigationLink {
                        PhrasebookView(initialCategory: category)
                    } label: {
                        VStack(alignment: .leading, spacing: 12) {
                            Image(systemName: category.systemImage)
                                .font(.title3)
                                .foregroundStyle(category.tint)

                            Text(category.title)
                                .font(.headline)
                                .foregroundStyle(.ink)

                            Text("\(LearningData.phrases(in: category).count) phrases")
                                .font(.caption)
                                .foregroundStyle(.mutedInk)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity, minHeight: 118, alignment: .leading)
                        .background(category.tint.opacity(0.10))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DashboardView()
                .environmentObject(ReviewStore(inMemory: true))
        }
    }
}
