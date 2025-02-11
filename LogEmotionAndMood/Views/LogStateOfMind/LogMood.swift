//
//  LogMood.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogMood: View {
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date? = nil
    var isPrevLog: Bool = false
    
    var body: some View {
        LogStateOfMindValence(
            logStateOfMindModel: logStateOfMindModel,
            prevDate: prevDate,
            isPrevLog: isPrevLog,
            navTitle: "Mood"
        )
        .task {
            logStateOfMindModel.kind = .dailyMood
        }
    }
}

#Preview {
    NavigationStack {
        LogMood(logStateOfMindModel: LogStateOfMindViewModel())
    }
}
