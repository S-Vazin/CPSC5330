import SwiftUI

/// Main list screen showing all Portalheart codex entries.
/// Acts as the View + simple Controller in MVC terms.
struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(codexEntries) { entry in
                NavigationLink(destination: DetailView(entry: entry)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.name)
                            .font(.headline)
                        Text(entry.category)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Portalheart Codex")
        }
    }
}

#Preview {
    ContentView()
}
