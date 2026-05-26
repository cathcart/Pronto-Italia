import AVFoundation
import SwiftUI

extension Color {
    static let appBackground = Color(red: 0.96, green: 0.97, blue: 0.95)
    static let panel = Color.white
    static let ink = Color(red: 0.10, green: 0.13, blue: 0.16)
    static let mutedInk = Color(red: 0.36, green: 0.40, blue: 0.44)
    static let italiaGreen = Color(red: 0.02, green: 0.49, blue: 0.35)
    static let tomato = Color(red: 0.83, green: 0.19, blue: 0.16)
    static let signalBlue = Color(red: 0.11, green: 0.35, blue: 0.71)
    static let olive = Color(red: 0.44, green: 0.49, blue: 0.21)
    static let violet = Color(red: 0.42, green: 0.29, blue: 0.63)
    static let sunset = Color(red: 0.86, green: 0.45, blue: 0.18)
    static let deepRed = Color(red: 0.64, green: 0.08, blue: 0.12)
}

extension ShapeStyle where Self == Color {
    static var appBackground: Color { Color.appBackground }
    static var panel: Color { Color.panel }
    static var ink: Color { Color.ink }
    static var mutedInk: Color { Color.mutedInk }
    static var italiaGreen: Color { Color.italiaGreen }
    static var tomato: Color { Color.tomato }
    static var signalBlue: Color { Color.signalBlue }
    static var olive: Color { Color.olive }
    static var violet: Color { Color.violet }
    static var sunset: Color { Color.sunset }
    static var deepRed: Color { Color.deepRed }
}

final class SpeechPlayer: ObservableObject {
    private let synthesizer: AVSpeechSynthesizer = {
        let synthesizer = AVSpeechSynthesizer()
        // Pronunciation clips are the only audio in the app, so let iOS manage
        // speech routing and interruptions rather than maintaining an app session.
        #if os(iOS) || os(tvOS) || os(watchOS) || targetEnvironment(macCatalyst)
        synthesizer.usesApplicationAudioSession = false
        #endif
        return synthesizer
    }()

    func speak(_ text: String) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.84
        utterance.pitchMultiplier = 1.0
        synthesizer.speak(utterance)
    }
}

struct SpeakButton: View {
    @EnvironmentObject private var player: SpeechPlayer
    let text: String
    var compact = false

    var body: some View {
        Button {
            player.speak(text)
        } label: {
            if compact {
                Image(systemName: "speaker.wave.2.fill")
            } else {
                Label("Play", systemImage: "speaker.wave.2.fill")
            }
        }
        .buttonStyle(.bordered)
        .tint(.italiaGreen)
        .accessibilityLabel("Play Italian pronunciation")
    }
}

struct CardSurface<Content: View>: View {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.panel)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: .black.opacity(0.06), radius: 14, x: 0, y: 8)
    }
}

struct CategoryBadge: View {
    let category: PhraseCategory

    var body: some View {
        Label(category.title, systemImage: category.systemImage)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .foregroundStyle(category.tint)
            .background(category.tint.opacity(0.12))
            .clipShape(Capsule())
    }
}

struct MetricTile: View {
    let title: String
    let value: String
    let systemImage: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: systemImage)
                .font(.headline)
                .foregroundStyle(tint)
                .frame(width: 32, height: 32)
                .background(tint.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(value)
                .font(.title2.bold())
                .foregroundStyle(.ink)

            Text(title)
                .font(.caption)
                .foregroundStyle(.mutedInk)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.panel)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct EmptyStudyState: View {
    let title: String
    let message: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.system(size: 42))
                .foregroundStyle(.italiaGreen)

            Text(title)
                .font(.headline)
                .foregroundStyle(.ink)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.mutedInk)
                .multilineTextAlignment(.center)
        }
        .padding(28)
        .frame(maxWidth: .infinity)
    }
}

struct ChipButton: View {
    let title: String
    let isSelected: Bool
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(isSelected ? .white : tint)
                .padding(.horizontal, 14)
                .padding(.vertical, 9)
                .background(isSelected ? tint : tint.opacity(0.12))
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
