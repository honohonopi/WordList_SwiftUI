//
//  WordListApp.swift
//  WordList
//
//  Created by Honoka Nishiyama on 2025/06/24.
//

import SwiftUI
import SwiftData

@main
struct WordListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Word.self)
        }
    }
}
