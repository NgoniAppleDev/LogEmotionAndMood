//
//  LogEmotion.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogEmotion: View {
    @Binding var logStateOfMindModel: LogStateOfMindViewModel
    
    var body: some View {
        LogStateOfMindValence(logStateOfMindModel: $logStateOfMindModel)
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

