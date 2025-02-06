//
//  LogMood.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogMood: View {
    @Binding var logStateOfMindModel: LogStateOfMindViewModel
    
    var body: some View {
        LogStateOfMindValence(logStateOfMindModel: $logStateOfMindModel, navTitle: "Mood", kind: .dailyMood)
            .onAppear {
                logStateOfMindModel.kind = .dailyMood
            }
    }
}

#Preview {
    NavigationStack {
        LogMood(logStateOfMindModel: .constant(LogStateOfMindViewModel()))
    }
}
