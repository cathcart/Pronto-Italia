import Combine
import Foundation

final class ReviewStore: ObservableObject {
    @Published private(set) var records: [String: ReviewRecord] = [:] {
        didSet { save() }
    }

    private let storageKey = "ProntoItalia.review.records"
    private let calendar = Calendar.current
    private let inMemory: Bool

    init(inMemory: Bool = false) {
        self.inMemory = inMemory
        load()
    }

    func duePhrases(from phrases: [Phrase], now: Date = Date()) -> [Phrase] {
        phrases.filter { phrase in
            let record = records[phrase.id] ?? ReviewRecord()
            return record.dueDate <= now
        }
    }

    func masteredCount(from phrases: [Phrase]) -> Int {
        phrases.filter { phrase in
            (records[phrase.id]?.box ?? 1) >= 4
        }.count
    }

    func record(_ phrase: Phrase, grade: ReviewGrade, now: Date = Date()) {
        var record = records[phrase.id] ?? ReviewRecord()
        let nextBox: Int
        let dueDate: Date

        switch grade {
        case .again:
            nextBox = 1
            record.correctStreak = 0
            dueDate = calendar.date(byAdding: .hour, value: 8, to: now) ?? now
        case .hard:
            nextBox = max(1, record.box)
            record.correctStreak = max(0, record.correctStreak)
            dueDate = calendar.date(byAdding: .day, value: 1, to: now) ?? now
        case .good:
            nextBox = min(5, record.box + 1)
            record.correctStreak += 1
            dueDate = calendar.date(byAdding: .day, value: intervalDays(for: nextBox), to: now) ?? now
        case .easy:
            nextBox = min(5, record.box + 2)
            record.correctStreak += 1
            dueDate = calendar.date(byAdding: .day, value: intervalDays(for: nextBox), to: now) ?? now
        }

        record.box = nextBox
        record.dueDate = dueDate
        record.lastReviewed = now
        records[phrase.id] = record
    }

    func resetProgress() {
        records = [:]
    }

    private func intervalDays(for box: Int) -> Int {
        switch box {
        case 1: 0
        case 2: 1
        case 3: 3
        case 4: 7
        default: 14
        }
    }

    private func load() {
        guard !inMemory else { return }
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        guard let decoded = try? JSONDecoder().decode([String: ReviewRecord].self, from: data) else { return }
        records = decoded
    }

    private func save() {
        guard !inMemory else { return }
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}
