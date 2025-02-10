//
//  LogEmotion.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogEmotion: View {
    @Binding var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date = Date()
    var isPrevLog: Bool = false
    
    var body: some View {
        LogStateOfMindValence(
            logStateOfMindModel: logStateOfMindModel,
            prevDate: prevDate,
            isPrevLog: isPrevLog
        )
            .onAppear {
                logStateOfMindModel.kind = .momentaryEmotion
            }
    }
}

#Preview {
    NavigationStack {
        LogEmotion(logStateOfMindModel: .constant(LogStateOfMindViewModel()))
    }
}

