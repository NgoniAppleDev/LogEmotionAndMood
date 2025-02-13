//
//  ContentView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct ContentView: View {
    @Binding var enabled: Bool
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    @Bindable var readStateOfMindModel: ReadStateOfMindViewModel
    
    var body: some View {
        NavigationStack {
            ZStackWithGradient {
                List {
                    Section("Connect your data") {
                        NavigationLink(destination: AppleHealthView(enabled: $enabled)) {
                            Text("Apple Health")
                        }
                        .padding()
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 12.0))
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    
                    Section("Log State of Mind") {
                        Button { logStateOfMindModel.isShowingLogStateOfMind = true } label: {
                            HStack {
                                Text("😃 How are you feeling?")
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 12.0))
                        }
                        .buttonStyle(.plain)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    
                    Section("Read State of Mind Data") {
                        NavigationLink(
                            "See The Data",
                            destination: ReadStateOfMindData(
                                logStateOfMindModel: logStateOfMindModel,
                                readStateOfMindModel: readStateOfMindModel
                            )
                        )
                        .padding()
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 12.0))
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    
                    Section("Insights") {
                        NavigationLink(
                            "Analyze the Data",
                            destination: Insights()
                        )
                        .padding()
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 12.0))
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Health Kit")
            .sheet(isPresented: $logStateOfMindModel.isShowingLogStateOfMind) {
                NavigationStack {
                    LogStateOfMindView(
                        logStateOfMindModel: logStateOfMindModel
                    )
                }
                .interactiveDismissDisabled()
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }
    
}

#Preview {
    ContentView(
        enabled: .constant(false),
        logStateOfMindModel: LogStateOfMindViewModel(),
        readStateOfMindModel: ReadStateOfMindViewModel()
    )
}
