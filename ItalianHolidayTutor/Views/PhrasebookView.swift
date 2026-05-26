import SwiftUI

struct PhrasebookView: View {
    @State private var selectedCategory: PhraseCategory?
    @State private var searchText = ""

    init(initialCategory: PhraseCategory? = nil) {
        _selectedCategory = State(initialValue: initialCategory)
    }

    private var filteredPhrases: [Phrase] {
        let categoryFiltered = LearningData.phrases(in: selectedCategory)
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return categoryFiltered
        }

        let query = searchText.localizedLowercase
        return categoryFiltered.filter { phrase in
            phrase.italian.localizedLowercase.contains(query)
            || phrase.english.localizedLowercase.contains(query)
            || phrase.keywords.contains { $0.localizedLowercase.contains(query) }
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                categorySelector

                ForEach(filteredPhrases) { phrase in
                    PhraseRow(phrase: phrase)
                }

                if filteredPhrases.isEmpty {
                    EmptyStudyState(
                        title: "No matching phrase",
                        message: "Try a travel word like train, card, hotel, water, or pharmacy.",
                        systemImage: "magnifyingglass"
                    )
                }
            }
            .padding(18)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Phrasebook")
        .searchable(text: $searchText, prompt: "Search English or Italian")
    }

    private var categorySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ChipButton(
                    title: "All",
                    isSelected: selectedCategory == nil,
                    tint: .ink,
                    action: { selectedCategory = nil }
                )

                ForEach(PhraseCategory.allCases) { category in
                    ChipButton(
                        title: category.title,
                        isSelected: selectedCategory == category,
                        tint: category.tint,
                        action: { selectedCategory = category }
                    )
                }
            }
            .padding(.vertical, 2)
        }
    }
}

private struct PhraseRow: View {
    let phrase: Phrase

    var body: some View {
        CardSurface {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .leading, spacing: 7) {
                        CategoryBadge(category: phrase.category)

                        Text(phrase.italian)
                            .font(.title3.weight(.bold))
                            .foregroundStyle(.ink)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(phrase.english)
                            .font(.body)
                            .foregroundStyle(.mutedInk)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    SpeakButton(text: phrase.italian, compact: true)
                }

                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Image(systemName: "puzzlepiece.extension.fill")
                        .foregroundStyle(phrase.category.tint)

                    Text(phrase.chunk)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(phrase.category.tint)

                    Text(phrase.note)
                        .font(.subheadline)
                        .foregroundStyle(.mutedInk)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
}

struct PhrasebookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PhrasebookView()
        }
        .environmentObject(SpeechPlayer())
    }
}
