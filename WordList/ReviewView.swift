//
//  ReviewView.swift
//  WordList
//
//  Created by Honoka Nishiyama on 2025/06/29.
//

import SwiftUI
import SwiftData

struct ReviewView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    // isWrong == true の単語だけを取得
    @Query var words: [Word]
    
    private var wrongWords: [Word] {
      words.filter { $0.isWrong }
    }

    @State private var index = 0
    @State private var showAnswer = false

    private var isLastQuiz: Bool {
        index + 1 >= wrongWords.count
    }

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            if wrongWords.isEmpty {
                Text("復習する単語がありません")
            } else {
                Text(wrongWords[index].english)
                    .font(.largeTitle)
                Text(showAnswer ? wrongWords[index].japanese : "-")
                    .font(.largeTitle)
                Button {
                    showAnswer.toggle()
                } label: {
                    Text(showAnswer ? "回答を非表示" : "回答を表示")
                }
                .font(.title)
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.orange)
                .clipShape(.capsule)
            }
            Spacer()
            Button {
                if isLastQuiz {
                    wrongWords.forEach { $0.isWrong = false }
//                    index = 0
//                    showAnswer = false
                    dismiss()
                } else {
                    index += 1
                    showAnswer = false
                }
            } label: {
                Text(isLastQuiz ? "復習完了！" : "次へ")
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .clipShape(.capsule)
            Spacer()
        }
        .padding(.horizontal, 60)
        .navigationTitle("間違えた単語を復習")
    }
}

#Preview {
    ReviewView()
        .modelContainer(wordContainer)
}
