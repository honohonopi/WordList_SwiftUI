//
//  Word.swift
//  WordList
//
//  Created by Honoka Nishiyama on 2025/06/24.
//

import SwiftData

@Model
class Word{
    var english: String
    var japanese: String
    init(english: String, japanese: String) {
        self.english = english
        self.japanese = japanese
    }
}
