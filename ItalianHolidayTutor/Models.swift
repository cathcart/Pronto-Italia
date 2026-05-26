import SwiftUI

enum PhraseCategory: String, CaseIterable, Identifiable, Codable {
    case travel
    case food
    case money
    case hotel
    case directions
    case social
    case emergency

    var id: String { rawValue }

    var title: String {
        switch self {
        case .travel: "Travel"
        case .food: "Food"
        case .money: "Money"
        case .hotel: "Hotel"
        case .directions: "Directions"
        case .social: "Social"
        case .emergency: "Emergency"
        }
    }

    var systemImage: String {
        switch self {
        case .travel: "tram.fill"
        case .food: "fork.knife"
        case .money: "creditcard.fill"
        case .hotel: "bed.double.fill"
        case .directions: "map.fill"
        case .social: "bubble.left.and.bubble.right.fill"
        case .emergency: "cross.case.fill"
        }
    }

    var tint: Color {
        switch self {
        case .travel: .signalBlue
        case .food: .tomato
        case .money: .olive
        case .hotel: .violet
        case .directions: .italiaGreen
        case .social: .sunset
        case .emergency: .deepRed
        }
    }
}

struct Phrase: Identifiable, Hashable, Codable {
    let id: String
    let category: PhraseCategory
    let italian: String
    let english: String
    let chunk: String
    let note: String
    let keywords: [String]
}

struct DailyPlanStep: Identifiable {
    let id = UUID()
    let title: String
    let minutes: Int
    let systemImage: String
    let method: String
    let instruction: String
    let tint: Color
}

struct PracticeQuestion: Identifiable, Hashable {
    let id = UUID()
    let prompt: String
    let options: [String]
    let answer: String
    let explanation: String
}

struct ReconstructionExercise: Identifiable, Hashable {
    let id = UUID()
    let englishPrompt: String
    let target: String
    let words: [String]
}

struct TravelScenario: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let setting: String
    let goal: String
    let systemImage: String
    let focusChunks: [String]
    let phrases: [Phrase]
    let questions: [PracticeQuestion]
    let reconstruction: ReconstructionExercise
    let outputPrompt: String
}

struct ListeningResource: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let level: String
    let cadence: String
    let url: String
    let systemImage: String
    let whyItHelps: String
    let mission: String
}

struct ReviewRecord: Codable, Equatable {
    var box: Int
    var dueDate: Date
    var correctStreak: Int
    var lastReviewed: Date?

    init(box: Int = 1, dueDate: Date = .distantPast, correctStreak: Int = 0, lastReviewed: Date? = nil) {
        self.box = box
        self.dueDate = dueDate
        self.correctStreak = correctStreak
        self.lastReviewed = lastReviewed
    }
}

enum ReviewGrade {
    case again
    case hard
    case good
    case easy

    var title: String {
        switch self {
        case .again: "Again"
        case .hard: "Hard"
        case .good: "Got it"
        case .easy: "Easy"
        }
    }

    var systemImage: String {
        switch self {
        case .again: "arrow.counterclockwise"
        case .hard: "minus.circle"
        case .good: "checkmark.circle"
        case .easy: "sparkles"
        }
    }

    var tint: Color {
        switch self {
        case .again: .deepRed
        case .hard: .sunset
        case .good: .italiaGreen
        case .easy: .signalBlue
        }
    }
}
