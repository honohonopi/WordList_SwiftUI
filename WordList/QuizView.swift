//
//  QuizView.swift
//  WordList
//
//  Created by Honoka Nishiyama on 2025/06/24.
//

import SwiftUI
import SwiftData

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var words: [Word]
    @State var index = 0
    @State var showAnswer = false
    
    var isLastQuiz: Bool{
        index + 1 >= words.count
    }
    var body: some View {
        VStack(spacing: 24){
            Spacer()
            if words.isEmpty {
                Text("登録されている単語がありません")
            } else {
                Text(words[index].english)
                    .font(.largeTitle)
                Text(showAnswer ? words[index].japanese: "-")
                    .font(.largeTitle)
                Button{
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
                if showAnswer {
                    let current = words[index]
                    Button {
                        withAnimation {
                            current.isWrong = true
                        }
                    } label: {
                        Text(current.isWrong
                             ? "復習リストに追加済み"
                             : "復習リストに登録")
                        .font(.body)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                    }
                    .foregroundStyle(.white)
                    .background(current.isWrong
                                ? Color.gray
                                : Color.red.opacity(0.8))
                    .clipShape(Capsule())
                    .disabled(current.isWrong)
                }
            }
            Spacer()
            Button{
                if isLastQuiz{
                    dismiss()
                } else {
                    index += 1
                }
            } label: {
                Text(isLastQuiz ? "終了!" : "次の問題へ")
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
    }
}

#Preview {
    QuizView()
        .modelContainer(wordContainer)
}
