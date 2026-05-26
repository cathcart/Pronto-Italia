import SwiftUI

struct ScenarioView: View {
    @State private var selectedIndex = 0
    @State private var questionIndex = 0
    @State private var selectedAnswer: String?

    private var scenario: TravelScenario {
        LearningData.scenarios[selectedIndex]
    }

    private var question: PracticeQuestion {
        scenario.questions[questionIndex]
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                scenarioSelector
                scenarioHeader
                inputFlood
                questionCard
                SentenceBuilder(exercise: scenario.reconstruction)
                outputCard
            }
            .padding(18)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Practice")
        .onChange(of: selectedIndex) { _, _ in
            resetQuestion()
        }
    }

    private var scenarioSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(LearningData.scenarios.enumerated()), id: \.offset) { index, scenario in
                    ChipButton(
                        title: scenario.title,
                        isSelected: selectedIndex == index,
                        tint: .italiaGreen,
                        action: { selectedIndex = index }
                    )
                }
            }
            .padding(.vertical, 2)
        }
    }

    private var scenarioHeader: some View {
        CardSurface {
            HStack(alignment: .top, spacing: 14) {
                Image(systemName: scenario.systemImage)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(Color.italiaGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                VStack(alignment: .leading, spacing: 8) {
                    Text(scenario.setting)
                        .font(.caption.weight(.bold))
                        .textCase(.uppercase)
                        .foregroundStyle(.mutedInk)

                    Text(scenario.goal)
                        .font(.headline)
                        .foregroundStyle(.ink)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("Focus chunks: \(scenario.focusChunks.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundStyle(.italiaGreen)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private var inputFlood: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Input flood", systemImage: "ear.badge.waveform")
                .font(.headline)
                .foregroundStyle(.ink)

            ForEach(scenario.phrases) { phrase in
                CardSurface {
                    HStack(alignment: .top, spacing: 12) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(phrase.italian)
                                .font(.headline)
                                .foregroundStyle(.ink)

                            Text(phrase.english)
                                .font(.subheadline)
                                .foregroundStyle(.mutedInk)

                            Text(phrase.chunk)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(phrase.category.tint)
                        }

                        Spacer()

                        SpeakButton(text: phrase.italian, compact: true)
                    }
                }
            }
        }
    }

    private var questionCard: some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Label("Recognition check", systemImage: "checklist")
                        .font(.headline)
                        .foregroundStyle(.signalBlue)

                    Spacer()

                    Text("\(questionIndex + 1)/\(scenario.questions.count)")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.mutedInk)
                }

                Text(question.prompt)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.ink)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 8) {
                    ForEach(question.options, id: \.self) { option in
                        Button {
                            selectedAnswer = option
                        } label: {
                            HStack {
                                Text(option)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(optionTextColor(option))
                                    .fixedSize(horizontal: false, vertical: true)

                                Spacer()

                                if selectedAnswer != nil {
                                    Image(systemName: option == question.answer ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(option == question.answer ? Color.italiaGreen : Color.mutedInk.opacity(0.45))
                                }
                            }
                            .padding(12)
                            .background(optionBackground(option))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }

                if let selectedAnswer {
                    Label(
                        selectedAnswer == question.answer ? question.explanation : "Not quite. \(question.explanation)",
                        systemImage: selectedAnswer == question.answer ? "lightbulb.fill" : "arrow.counterclockwise"
                    )
                    .font(.subheadline)
                    .foregroundStyle(selectedAnswer == question.answer ? .italiaGreen : .tomato)
                    .fixedSize(horizontal: false, vertical: true)

                    Button {
                        nextQuestion()
                    } label: {
                        Label("Next check", systemImage: "arrow.right")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.signalBlue)
                }
            }
        }
    }

    private var outputCard: some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 12) {
                Label("Pushed output", systemImage: "waveform")
                    .font(.headline)
                    .foregroundStyle(.tomato)

                Text(scenario.outputPrompt)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.ink)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Say it once slowly, then again at normal speed. Use the phrase list above only if you get stuck.")
                    .font(.subheadline)
                    .foregroundStyle(.mutedInk)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    private func optionBackground(_ option: String) -> Color {
        guard let selectedAnswer else { return Color.signalBlue.opacity(0.10) }
        if option == question.answer {
            return Color.italiaGreen.opacity(0.16)
        }
        if option == selectedAnswer {
            return Color.tomato.opacity(0.14)
        }
        return Color.signalBlue.opacity(0.06)
    }

    private func optionTextColor(_ option: String) -> Color {
        guard selectedAnswer != nil else { return .ink }
        return option == question.answer ? .italiaGreen : .ink
    }

    private func nextQuestion() {
        withAnimation(.snappy) {
            questionIndex = (questionIndex + 1) % scenario.questions.count
            selectedAnswer = nil
        }
    }

    private func resetQuestion() {
        questionIndex = 0
        selectedAnswer = nil
    }
}

private struct SentenceBuilder: View {
    let exercise: ReconstructionExercise
    @State private var selectedWords: [String] = []
    @State private var availableWords: [String] = []

    private var builtSentence: String {
        selectedWords.joined(separator: " ")
    }

    private var isComplete: Bool {
        availableWords.isEmpty
    }

    private var isCorrect: Bool {
        builtSentence == exercise.target
    }

    var body: some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 14) {
                Label("Build the line", systemImage: "text.insert")
                    .font(.headline)
                    .foregroundStyle(.sunset)

                Text(exercise.englishPrompt)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.mutedInk)

                Text(builtSentence.isEmpty ? "Tap words below" : builtSentence)
                    .font(.title3.weight(.bold))
                    .foregroundStyle(isComplete && !isCorrect ? .tomato : .ink)
                    .frame(maxWidth: .infinity, minHeight: 56, alignment: .leading)
                    .padding(12)
                    .background(Color.sunset.opacity(0.10))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                LazyVGrid(columns: [GridItem(.adaptive(minimum: 92), spacing: 8)], spacing: 8) {
                    ForEach(Array(availableWords.enumerated()), id: \.offset) { index, word in
                        Button {
                            selectedWords.append(word)
                            availableWords.remove(at: index)
                        } label: {
                            Text(word)
                                .font(.subheadline.weight(.semibold))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .tint(.sunset)
                    }
                }

                if isComplete {
                    Label(
                        isCorrect ? "Nice. Now say it without looking." : "Close. Reset and rebuild the word order.",
                        systemImage: isCorrect ? "checkmark.circle.fill" : "arrow.counterclockwise"
                    )
                    .font(.subheadline)
                    .foregroundStyle(isCorrect ? .italiaGreen : .tomato)
                }

                HStack {
                    Button {
                        reset()
                    } label: {
                        Label("Reset", systemImage: "arrow.counterclockwise")
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    SpeakButton(text: exercise.target)
                }
            }
        }
        .onAppear {
            if availableWords.isEmpty && selectedWords.isEmpty {
                availableWords = exercise.words.shuffled()
            }
        }
        .onChange(of: exercise.id) { _, _ in
            reset()
        }
    }

    private func reset() {
        selectedWords = []
        availableWords = exercise.words.shuffled()
    }
}

struct ScenarioView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ScenarioView()
        }
        .environmentObject(SpeechPlayer())
    }
}
