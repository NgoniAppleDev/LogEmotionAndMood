//
//  LogEmotion.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogEmotion: View {
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date? = nil
    var isPrevLog: Bool = false
    
    var body: some View {
        LogStateOfMindValence(
            logStateOfMindModel: logStateOfMindModel,
            prevDate: prevDate,
            isPrevLog: isPrevLog
        )
        .task {
            logStateOfMindModel.kind = .momentaryEmotion
        }
    }
}

#Preview {
    NavigationStack {
        LogEmotion(logStateOfMindModel: LogStateOfMindViewModel())
    }
}

