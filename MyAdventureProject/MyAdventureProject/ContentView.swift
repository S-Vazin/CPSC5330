//
//  ContentView.swift
//  MyAdventureProject
//
//  View layer for MyAdventure (MVC)
//

import SwiftUI

struct ContentView: View {
    @StateObject private var controller = AdventureController()
    @Environment(\.horizontalSizeClass) private var hSize
    @Environment(\.verticalSizeClass) private var vSize

    var body: some View {
        AdaptiveContainer {
            adventureContent
        }
        .padding()
        .animation(.default, value: controller.currentNode.id)
    }

    @ViewBuilder
    private var adventureContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            description
            optionsOrEnding
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationTitle("MyAdventure")
        .toolbar { ToolbarItem(placement: .topBarTrailing) { restartButton } }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(controller.currentNode.title)
                .font(.largeTitle).bold()
                .accessibilityAddTraits(.isHeader)
            ProgressView(value: progressValue)
                .tint(.accentColor)
        }
    }

    private var description: some View {
        Text(controller.currentNode.description)
            .font(.body)
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
    }

    @ViewBuilder
    private var optionsOrEnding: some View {
        if let outcome = controller.currentNode.outcome {
            switch outcome {
            case .success(let msg):
                endingView(isSuccess: true, message: msg)
            case .failure(let msg):
                endingView(isSuccess: false, message: msg)
            }
        } else {
            optionsList
        }
    }

    private var optionsList: some View {
        let options = controller.currentNode.options
        return VStack(alignment: .leading, spacing: 12) {
            Text("Choose your path:")
                .font(.headline)
            ForEach(options as [AdventureOption], id: \.id) { option in
                Button(action: { controller.choose(option) }) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundStyle(.tint)
                        Text(option.title)
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .buttonStyle(.plain)
                .accessibilityHint("Navigates to the next scene")
            }
        }
    }

    @ViewBuilder
    private func endingView(isSuccess: Bool, message: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(isSuccess ? "Success" : "Unsuccessful", systemImage: isSuccess ? "checkmark.seal.fill" : "xmark.octagon.fill")
                .font(.title2.weight(.semibold))
                .foregroundStyle(isSuccess ? .green : .red)
            Text(message)
                .font(.body)
            HStack {
                Button("Play Again", action: controller.restart)
                    .buttonStyle(.borderedProminent)
                Button("Back to Start", action: controller.restart)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var restartButton: some View {
        Button {
            controller.restart()
        } label: {
            Label("Restart", systemImage: "arrow.counterclockwise")
        }
        .keyboardShortcut("r")
        .accessibilityLabel("Restart Adventure")
    }

    private var progressValue: Double {
        // Very rough progress: count hops from start by matching known ids
        let id = controller.currentNode.id
        switch id {
        case "start": return 0.0
        case "bright", "dim": return 0.33
        case "runes", "careful": return 0.66
        default: return 1.0
        }
    }
}

// MARK: - Adaptive Container
/// A simple wrapper that adapts layout for iPhone/iPad and landscape using size classes.
private struct AdaptiveContainer<Content: View>: View {
    @Environment(\.horizontalSizeClass) private var hSize
    @Environment(\.verticalSizeClass) private var vSize
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        Group {
            if hSize == .regular && vSize == .regular {
                // iPad portrait or large screens: center with wider readable width
                content()
                    .frame(maxWidth: 700)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(BackgroundDecoration())
            } else if hSize == .regular && vSize == .compact {
                // iPad landscape: use a side-by-side style area
                HStack(spacing: 24) {
                    content()
                        .frame(maxWidth: 600)
                    Spacer(minLength: 0)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundDecoration())
            } else {
                // iPhone sizes: standard padding, scroll if needed
                ScrollView {
                    content()
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(BackgroundDecoration())
            }
        }
    }
}

private struct BackgroundDecoration: View {
    var body: some View {
        LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
