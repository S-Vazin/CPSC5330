import SwiftUI

/// Detail screen showing information about the tapped codex entry.
struct DetailView: View {
    let entry: CodexEntry   // data passed from ContentView

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(entry.name)
                    .font(.largeTitle)
                    .bold()

                Text(entry.category)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Divider()

                Text(entry.summary)
                    .font(.body)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(entry.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(
        entry: CodexEntry(
            name: "Portalheart",
            category: "Core System",
            summary: "The central engine that connects maps, data tools, and story frameworks."
        )
    )
}
