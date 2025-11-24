import Foundation

// Represents a single selectable option from a node
struct AdventureOption: Identifiable {
    let id: UUID = UUID()
    let title: String
    let nextNodeID: String
}

// Represents the end outcome of the adventure
enum AdventureOutcome: Equatable {
    case success(message: String)
    case failure(message: String)
}

// Represents a node (scene) in the adventure graph
struct AdventureNode: Identifiable {
    let id: String
    let title: String
    let description: String
    let options: [AdventureOption]
    let outcome: AdventureOutcome? // Non-nil if this is a terminal node
}

// Factory to build a simple adventure graph with at least 3 layers
enum AdventureGraphFactory {
    static func makeGraph() -> [String: AdventureNode] {
        // Endings
        let treasureChamber = AdventureNode(
            id: "treasure",
            title: "Treasure Chamber",
            description: "You decipher the runes and the door slides open. Inside, a golden idol rests on a pedestal. You carefully replace it with a sandbag of equal weight, and the temple stays quiet. You exit triumphantly!",
            options: [],
            outcome: .success(message: "You escaped with the idol!")
        )

        let collapseEnding = AdventureNode(
            id: "collapse",
            title: "Collapsing Tunnel",
            description: "You dash forward without checking the floor. A trap triggers and the tunnel begins to collapse. You make it out, but empty-handed and shaken.",
            options: [],
            outcome: .failure(message: "You escaped, but with no treasure.")
        )

        let pitTrapEnding = AdventureNode(
            id: "pit",
            title: "Hidden Pit",
            description: "The dim path conceals a hidden pit. You fall and barely climb out through a side passage, deciding the temple is too dangerous today.",
            options: [],
            outcome: .failure(message: "You survived, but the adventure ends here.")
        )

        // Layer 2 nodes
        let brightHall = AdventureNode(
            id: "bright",
            title: "Bright Hall",
            description: "Sunlight filters from above, illuminating intricate runes across the archway. A heavy stone door blocks your path.",
            options: [
                AdventureOption(title: "Study the runes", nextNodeID: "runes"),
                AdventureOption(title: "Force the door open", nextNodeID: "collapse")
            ],
            outcome: nil
        )

        let dimPassage = AdventureNode(
            id: "dim",
            title: "Dim Passage",
            description: "The air grows cooler as you move deeper. The floor is uneven and the walls are damp.",
            options: [
                AdventureOption(title: "Proceed carefully", nextNodeID: "careful"),
                AdventureOption(title: "Hurry through", nextNodeID: "pit")
            ],
            outcome: nil
        )

        // Layer 3 nodes
        let studyRunes = AdventureNode(
            id: "runes",
            title: "Ancient Runes",
            description: "The runes depict a balance. A symbol of a bag and a pedestal suggests equal weight.",
            options: [
                AdventureOption(title: "Use a sandbag to balance the pedestal", nextNodeID: "treasure"),
                AdventureOption(title: "Ignore the hint and push the door", nextNodeID: "collapse")
            ],
            outcome: nil
        )

        let carefulSteps = AdventureNode(
            id: "careful",
            title: "Careful Steps",
            description: "You prod the floor with a staff and find a safe route marked by subtle grooves.",
            options: [
                AdventureOption(title: "Follow the grooves", nextNodeID: "bright"),
                AdventureOption(title: "Try a shortcut", nextNodeID: "pit")
            ],
            outcome: nil
        )

        // Start node (Layer 1)
        let entrance = AdventureNode(
            id: "start",
            title: "Temple Entrance",
            description: "You stand before the entrance of an ancient jungle temple. Two paths diverge inside: one bright and ornate, the other dim and narrow.",
            options: [
                AdventureOption(title: "Take the bright hall", nextNodeID: "bright"),
                AdventureOption(title: "Take the dim passage", nextNodeID: "dim")
            ],
            outcome: nil
        )

        return [
            entrance.id: entrance,
            brightHall.id: brightHall,
            dimPassage.id: dimPassage,
            studyRunes.id: studyRunes,
            carefulSteps.id: carefulSteps,
            treasureChamber.id: treasureChamber,
            collapseEnding.id: collapseEnding,
            pitTrapEnding.id: pitTrapEnding
        ]
    }
}
