//
//  LogStateOfMindDescription.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI
import HealthKit

struct LogStateOfMindDescription: View {
    @Bindable var logStateOfMindModel: LogStateOfMindViewModel
    var prevDate: Date? = nil
    @State private var isShowingMore = false
    let adaptiveColumns = [GridItem(.adaptive(minimum: 75, maximum: 85))]
    
    var body: some View {
        let extractedValues = logStateOfMindModel.extractedValues
        
        ZStackWithGradient(color: extractedValues.faceColor) {
            VStack {
                ScrollView(showsIndicators: false) {
                    IconView(faceColor: extractedValues.faceColor, selectedMood: extractedValues.selectedMood, animateIcon: false, size: .medium)
                    Text(extractedValues.feeling)
                        .foregroundStyle(extractedValues.faceColor)
                        .font(.title.bold())
                        .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Tell me,")
                                .font(.title)
                            Text("Ngoni")
                                .font(.largeTitle)
                                .foregroundStyle(extractedValues.faceColor)
                            Spacer()
                        }
                        .fontWeight(.medium)
                        .padding(.vertical)
                        
                        Text("What best describes this feeling?")
                            .fontWeight(.medium)
                        
                        Divider()
                            .padding(.vertical)
                        
                        FlowLayoutView(items: logStateOfMindModel.allLabels) { label in
                            MoodLabelItem(
                                selectedItems: $logStateOfMindModel.selectedLabels,
                                item: label,
                                text: label.rawValue,
                                faceColor: extractedValues.faceColor
                            )
                        }
                        
                        Button {
                            isShowingMore = true
                        } label: {
                            HStack {
                                Text("Show More")
                                Image(systemName: "chevron.right")
                                    .font(.callout)
                            }
                        }
                        .foregroundStyle(.secondary)
                        .fontWeight(.medium)
                        .padding(.vertical)
                        
                    }
                }
                
                NavigationLink(destination: LogStateOfMindAssociation(
                    logStateOfMindModel: logStateOfMindModel, prevDate: prevDate
                )) {
                    Text("Next")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                        .contentShape(RoundedRectangle(cornerRadius: 12.0))
                }
                .buttonStyle(.plain)
                .background(extractedValues.faceColor, in: .rect(cornerRadius: 12.0))
            }
            .padding()
        }
        .toolbar {
            Button("Cancel") {
                logStateOfMindModel.cancelStateOfMindFlow()
            }
        }
        .sheet(isPresented: $isShowingMore) {
            NavigationStack {
                MoreStateOfMindLabels(selectedLabels: logStateOfMindModel.selectedLabels) { updatedLabels in
                    logStateOfMindModel.selectedLabels = updatedLabels
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LogStateOfMindDescription(
            logStateOfMindModel: LogStateOfMindViewModel()
        )
    }
}

struct MoreStateOfMindLabels: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedLabels: Set<StateOfMindLabel>
    var onSave: (Set<StateOfMindLabel>) -> Void
    @State private var editMode: EditMode = .active
    
    var header: some View {
        Text("What best describes this feeling?")
            .font(.callout.weight(.semibold))
            .textCase(.none)
            .foregroundColor(.primary)
    }
    
    var body: some View {
        List(selection: $selectedLabels) {
            Section(header: header) {
                ForEach(StateOfMindLabel.allCases, id: \.self) { label in
                    Text(label.rawValue)
                }
            }
        }
        .environment(\.editMode, $editMode)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
                    .tint(.red)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    onSave(selectedLabels)
                    dismiss()
                }
            }
        }
    }
}

