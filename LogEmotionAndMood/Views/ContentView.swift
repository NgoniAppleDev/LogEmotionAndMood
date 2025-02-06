//
//  ContentView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct ContentView: View {
    @Binding var enabled: Bool
    @State private var logStateOfMindModel: LogStateOfMindViewModel = .init()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Connect your data") {
                    NavigationLink(destination: AppleHealthView(enabled: $enabled)) {
                        Text("Apple Health")
                    }
                }
                
                Section("Log State of Minds") {
                    Button { logStateOfMindModel.isShowingLogStateOfMind = true } label: {
                        Text("😃 How are you feeling?")
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Health Kit")
            .sheet(isPresented: $logStateOfMindModel.isShowingLogStateOfMind) {
                NavigationStack {
                    LogStateOfMindView(logStateOfMindModel: $logStateOfMindModel)
                }
                .interactiveDismissDisabled()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }

}

#Preview {
    ContentView(enabled: .constant(false))
}
