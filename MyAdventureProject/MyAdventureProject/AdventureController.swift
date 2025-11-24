//
//  AdventureController.swift
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AdventureController: ObservableObject {
    @Published private(set) var currentNode: AdventureNode
    private let graph: [String: AdventureNode]

    init() {
        self.graph = AdventureGraphFactory.makeGraph()
        self.currentNode = graph["start"] ?? AdventureNode(
            id: "fallback",
            title: "Unknown",
            description: "Something went wrong.",
            options: [],
            outcome: .failure(message: "No starting node found.")
        )
    }

    func choose(_ option: AdventureOption) {
        guard let next = graph[option.nextNodeID] else { return }
        currentNode = next
    }

    func restart() {
        if let start = graph["start"] {
            currentNode = start
        }
    }
}
