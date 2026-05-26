import SwiftUI

struct ReviewView: View {
    @EnvironmentObject private var reviewStore: ReviewStore
    @State private var deck: [Phrase] = []
    @State private var isShowingAnswer = false
    @State private var mode: ReviewMode = .recognise

    private var currentPhrase: Phrase? {
        deck.first
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                header

                Picker("Mode", selection: $mode) {
                    ForEach(ReviewMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)

                if let phrase = currentPhrase {
                    reviewCard(for: phrase)
                    gradingButtons(for: phrase)
                } else {
                    CardSurface {
                        EmptyStudyState(
                            title: "Review complete",
                            message: "You have cleared the current deck. Start another sprint if you want a little extra practice.",
                            systemImage: "checkmark.seal.fill"
                        )

                        Button {
                            startSession()
                        } label: {
                            Label("Start another sprint", systemImage: "arrow.clockwise")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.italiaGreen)
                    }
                }
            }
            .padding(18)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Review")
        .toolbar {
            Button {
                startSession()
            } label: {
                Image(systemName: "shuffle")
            }
            .accessibilityLabel("Shuffle review deck")
        }
        .onAppear {
            if deck.isEmpty {
                startSession()
            }
        }
        .onChange(of: mode) { _, _ in
            isShowingAnswer = false
        }
    }

    private var header: some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Label("Spaced retrieval", systemImage: "brain.head.profile")
                        .font(.headline)
                        .foregroundStyle(.italiaGreen)

                    Spacer()

                    Text("\(deck.count) cards")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.mutedInk)
                }

                Text("Cards you miss return soon. Cards you know move farther out, which keeps practice effortful without cramming.")
                    .font(.subheadline)
                    .foregroundStyle(.mutedInk)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func reviewCard(for phrase: Phrase) -> some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    CategoryBadge(category: phrase.category)
                    Spacer()
                    SpeakButton(text: phrase.italian, compact: true)
                }

                Text(mode.promptTitle)
                    .font(.caption.weight(.bold))
                    .textCase(.uppercase)
                    .foregroundStyle(.mutedInk)

                Text(prompt(for: phrase))
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundStyle(.ink)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)

                if isShowingAnswer {
                    Divider()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Answer")
                            .font(.caption.weight(.bold))
                            .textCase(.uppercase)
                            .foregroundStyle(.mutedInk)

                        Text(answer(for: phrase))
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(phrase.category.tint)
                            .fixedSize(horizontal: false, vertical: true)

                        Label(phrase.note, systemImage: "lightbulb.fill")
                            .font(.subheadline)
                            .foregroundStyle(.mutedInk)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                } else {
                    Button {
                        withAnimation(.snappy) {
                            isShowingAnswer = true
                        }
                    } label: {
                        Label("Reveal answer", systemImage: "eye.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(phrase.category.tint)
                }
            }
        }
    }

    private func gradingButtons(for phrase: Phrase) -> some View {
        HStack(spacing: 8) {
            ForEach([ReviewGrade.again, .hard, .good, .easy], id: \.title) { grade in
                Button {
                    gradeCurrent(phrase, as: grade)
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: grade.systemImage)
                        Text(grade.title)
                            .font(.caption.weight(.semibold))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
                .tint(grade.tint)
                .disabled(!isShowingAnswer)
            }
        }
    }

    private func prompt(for phrase: Phrase) -> String {
        switch mode {
        case .recognise: phrase.italian
        case .recall: phrase.english
        }
    }

    private func answer(for phrase: Phrase) -> String {
        switch mode {
        case .recognise: phrase.english
        case .recall: phrase.italian
        }
    }

    private func startSession() {
        let due = reviewStore.duePhrases(from: LearningData.phrases)
        let source = due.isEmpty ? Array(LearningData.phrases.shuffled().prefix(12)) : due
        deck = source.shuffled()
        isShowingAnswer = false
    }

    private func gradeCurrent(_ phrase: Phrase, as grade: ReviewGrade) {
        reviewStore.record(phrase, grade: grade)
        withAnimation(.snappy) {
            if !deck.isEmpty {
                deck.removeFirst()
            }
            isShowingAnswer = false
        }
    }
}

private enum ReviewMode: String, CaseIterable, Identifiable {
    case recognise
    case recall

    var id: String { rawValue }

    var title: String {
        switch self {
        case .recognise: "Recognise"
        case .recall: "Recall"
        }
    }

    var promptTitle: String {
        switch self {
        case .recognise: "What does this mean?"
        case .recall: "How would you say this?"
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReviewView()
                .environmentObject(ReviewStore(inMemory: true))
                .environmentObject(SpeechPlayer())
        }
    }
}
