import Foundation

/// Model for a single Portalheart codex entry (MVC: Model layer).
struct CodexEntry: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let summary: String
}

/// Hard-coded sample data (10+ items) rooted in the Portalheart setting.
let codexEntries: [CodexEntry] = [

    CodexEntry(
        name: "Portalheart",
        category: "Core System",
        summary:
        "Portalheart is the unseen engine that stitches worlds together. It tracks realms, regions, and routes between them, letting GMs treat the campaign like a living network instead of a static map. In fiction, Portalheart is the mythic core at the center of all gateways; in practice, it is the logic that remembers where players went, what they changed, and which threads are still tugging on them."
    ),

    CodexEntry(
        name: "Hexmap Explorer",
        category: "Tool",
        summary:
        "Hexmap Explorer is the cartographer’s lens over Aysta: a grid of 50×65 hexes representing deserts, jungles, fae borders, polluted wastelands, and more. Each hex can store encounters, factions, travel time, and GM notes. At the table, it becomes the visible skeleton of a West Marches game; beneath the hood, Portalheart uses it to attach lore and mechanics to specific coordinates so the world feels consistent when players return."
    ),

    CodexEntry(
        name: "Middlegate",
        category: "Realm Hub",
        summary:
        "Middlegate is the neutral waystation between realities, the place characters fall back to when maps spit them out or Fear tears a hole in the journey. In-story, it is a liminal modern city whose alleyways hide portal doors to stranger realms. Mechanically, Middlegate is the safe scene the GM can always cut back to when travel timers expire, allowing downtime, regrouping, and new hooks to surface."
    ),

    CodexEntry(
        name: "Aysta",
        category: "Realm",
        summary:
        "Aysta is the flagship shard-world of Portalheart, a continent broken into extreme biomes stitched edge to edge on the hex grid. Hearthmeadow grasslands touch factory-choked skylines, fae forests, and flesh-tunnels that should not exist. Aysta’s history is built from player actions over time: each delve, treaty, and disaster is recorded against specific hexes, slowly turning the map into a shared chronicle of what the table has done."
    ),

    CodexEntry(
        name: "Hearthmeadow",
        category: "Region",
        summary:
        "Hearthmeadow is the bright green threshold region that most parties see first. Its open fields and scattered villages are relatively safe, acting as a buffer between everyday adventurers and the stranger lands beyond. In Portalheart terms, Hearthmeadow is a low-threat band around Middlegate where new characters can cut their teeth, learn how travel timing and Fear work, and decide which direction into the unknown they want to push."
    ),

    CodexEntry(
        name: "Forsaken Depths",
        category: "Realm",
        summary:
        "The Forsaken Depths are a realm of living flesh and buried fire, ruled by the God of the Buried. Walls pulse, streets are made of scar tissue, and towers resemble vertebrae driven up from the dark. Hexes here are tuned for body horror and pressure: resources are plentiful but corrupting, and travel timers are crueler. The realm exists as a foil to Hearthmeadow, showing what happens when the world itself has already lost the fight."
    ),

    CodexEntry(
        name: "Silhouette of the Eclipse",
        category: "Deity",
        summary:
        "Silhouette of the Eclipse is the God of Darkness, Lord of Umbra, whose power lies in what people cannot see clearly. Silhouette corrupts the living and the dead under their shadow, turning soldiers and ghosts alike into warped minions. They feud constantly with Forsaken: one rules over what is buried below, the other over what is cloaked above. On the table, Silhouette’s influence justifies fear-based twists, curses that follow the party across hexes, and enemies that grow stronger the longer they are left in the dark."
    ),

    CodexEntry(
        name: "Forsaken, God of the Buried",
        category: "Deity",
        summary:
        "Forsaken, the God of the Buried, reigns over things that were meant to stay down. Their realm resembles a hell of bone, magma, and meat, where old wars and dead gods are compost. While Silhouette corrupts from the shadows, Forsaken erupts from below, dragging relics, demons, and half-finished cities back to the surface. Their rivalry with Silhouette defines many conflicts in Aysta, with mortals caught between slow corruption from above and brutal eruption from below."
    ),

    CodexEntry(
        name: "Fear Pool",
        category: "Mechanic",
        summary:
        "The Fear Pool is a shared GM currency that measures how tense the story has become. As players push deep into hostile hexes, delay rests, or tempt dangerous gods, the GM earns Fear. Fear can be spent to twist dice results, trigger “take the lower die” moments, or force hard travel consequences like Aysta ejecting the party back to Middlegate. It turns pacing into a visible resource, rewarding cautious play but also giving the GM tools to make the world hit back when tension peaks."
    ),

    CodexEntry(
        name: "Pantheon Forge",
        category: "Tool",
        summary:
        "Pantheon Forge is the Portalheart module for building and tracking gods, cults, and rivalries. It stores each deity’s domains, visual markers on the hexmap, and the specific bargains they offer mortals. Silhouette and Forsaken live here as data, along with local spirits, industrial patrons, and forgotten animal gods. Over time, Pantheon Forge lets a GM grow from a simple list of names into a network of divine politics that the players can exploit or suffer."
    ),

    CodexEntry(
        name: "Portal Logbook",
        category: "Tool",
        summary:
        "Portal Logbook is the campaign memory of Portalheart, a ledger that records where players have gone and what they left behind. Each entry ties sessions to specific hexes, NPCs, and unresolved hooks, so the GM can always see which threads are still dangling. In fiction, Logbooks are grimoires that update themselves when a portal is used; in play, they are how long-running West Marches games stay coherent even as different groups of players wander the same fractured world."
    )
]
