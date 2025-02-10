//
//  LogStateOfMindAssociation.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct LogStateOfMindAssociation: View {
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date = Date()
    let adaptiveColumns = [GridItem(.adaptive(minimum: 80, maximum: 90))]
    
    var body: some View {
        ZStackWithGradient(color: logStateOfMindModel.faceColor) {
            VStack {
                ScrollView(showsIndicators: false) {
                    IconView(faceColor: logStateOfMindModel.faceColor, selectedMood: logStateOfMindModel.selectedMood, animateIcon: false, size: .medium)
                    Text(logStateOfMindModel.feeling)
                        .foregroundStyle(logStateOfMindModel.faceColor)
                        .font(.title.bold())
                        .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Tell me,")
                                .font(.title)
                            Text("Ngoni")
                                .font(.largeTitle)
                                .foregroundStyle(logStateOfMindModel.faceColor)
                            Spacer()
                        }
                        .fontWeight(.medium)
                        .padding(.vertical)
                        
                        Text("Which of these is having the biggest impact on you?")
                            .fontWeight(.medium)
                        
                        Divider()
                            .padding(.vertical)
                        
                        VStack (spacing: 20.0) {
                            FlowLayoutView(items: Array(logStateOfMindModel.allAssociations.prefix(6))) { association in
                                MoodLabelItem(
                                    selectedItems: $logStateOfMindModel.selectedAssociations,
                                    item: association,
                                    text: association.rawValue,
                                    faceColor: logStateOfMindModel.faceColor
                                )
                            }
                            
                            FlowLayoutView(items: Array(logStateOfMindModel.allAssociations.suffix(from: 6).prefix(5))) { association in
                                MoodLabelItem(
                                    selectedItems: $logStateOfMindModel.selectedAssociations,
                                    item: association,
                                    text: association.rawValue,
                                    faceColor: logStateOfMindModel.faceColor
                                )
                            }
                            
                            FlowLayoutView(items: Array(logStateOfMindModel.allAssociations.suffix(from: 11))) { association in
                                MoodLabelItem(
                                    selectedItems: $logStateOfMindModel.selectedAssociations,
                                    item: association,
                                    text: association.rawValue,
                                    faceColor: logStateOfMindModel.faceColor
                                )
                            }
                        }
                    }
                }
                
                Button {
                    Task {
                        await logStateOfMindModel.saveStateOfMind(date: prevDate)
                        logStateOfMindModel.cancelStateOfMindFlow()
                    }
                } label: {
                    Text("Done")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .contentShape(RoundedRectangle(cornerRadius: 12.0))
                }
                .buttonStyle(.plain)
                .background(logStateOfMindModel.faceColor, in: .rect(cornerRadius: 12.0))
                .padding(.top, 20)
            }
            .padding()
            .toolbar {
                Button("Cancel") { logStateOfMindModel.cancelStateOfMindFlow() }
            }
        }
    }
}

#Preview {
    LogStateOfMindAssociation(
        logStateOfMindModel: LogStateOfMindViewModel()
    )
}


