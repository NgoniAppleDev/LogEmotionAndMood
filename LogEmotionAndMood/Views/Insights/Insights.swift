//
//  Insights.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 12/2/2025.
//

import Charts
import HealthKit
import SwiftUI

struct Insights: View {
    var body: some View {
        List {
            Section {
                NavigationLink(destination: Text("destination")) {
                    TotalEntriesOverview()
                }
            }
            
            Section {
                NavigationLink(destination: Text("destination")) {
                    PopularFeelingOverview()
                }
            }
            
            Section {
                NavigationLink(destination: Text("destination")) {
                    StateOfMindTrend()
                }
            }
        }
        .navigationTitle("Insights")
    }
}

#Preview {
    NavigationStack {
        Insights()
    }
}

struct StateOfMindTrend: View {
    let symbolSize: CGFloat = 100
    let lineWidth: CGFloat = 3
    
    @State private var readStateOfMindModel: ReadStateOfMindViewModel = .init()
    @State private var statesOfMind: [HKStateOfMind] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("State of Mind Trend")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Chart {
                ForEach(statesOfMind, id: \.uuid) { stateOfMind in
//                    let interpolatedMood = MoodModel.interpolatedMoodMapping(for: stateOfMind.valence)
                    LineMark(
                        x: .value("Date", stateOfMind.endDate, unit: .weekday),
                        y: .value("Valence", stateOfMind.valence)
                    )
                }
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: lineWidth))
                .symbolSize(symbolSize)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .day)) { _ in
                    AxisTick()
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.weekday(.narrow), centered: true)
                }
            }
            .chartYScale(range: .plotDimension(endPadding: 8))
            .chartLegend(.hidden)
            .frame(height: 180)
            .task {
                statesOfMind = await readStateOfMindModel.getStateOfMindData()
            }
        }
    }
}

struct PopularFeelingOverview: View {
    @State private var readStateOfMindModel: ReadStateOfMindViewModel = .init()
    
    @State private var statesOfMind: [HKStateOfMind] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular Feeling")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Chart {
                ForEach(statesOfMind, id: \.uuid) { stateOfMind in
                    let interpolatedMood = MoodModel.interpolatedMoodMapping(for: stateOfMind.valence)
                    SectorMark(
                        angle: .value("Valence", stateOfMind.valence),
                        innerRadius: .ratio(0.618),
                        outerRadius: .inset(10),
                        angularInset: 1
                    )
                    .cornerRadius(4)
                    .foregroundStyle(by: .value("StateOfMind Feeling", interpolatedMood.feeling))
                }
            }
            .chartForegroundStyleScale([
                MoodModel.Mood.veryUnpleasant.rawValue : MoodModel.Mood.veryUnpleasant.getColor(),
                MoodModel.Mood.unPleasant.rawValue : MoodModel.Mood.unPleasant.getColor(),
                MoodModel.Mood.slightlyUnpleasant.rawValue : MoodModel.Mood.slightlyUnpleasant.getColor(),
                MoodModel.Mood.neutral.rawValue : MoodModel.Mood.neutral.getColor(),
                MoodModel.Mood.slightlyPleasant.rawValue : MoodModel.Mood.slightlyPleasant.getColor(),
                MoodModel.Mood.pleasant.rawValue : MoodModel.Mood.pleasant.getColor(),
                MoodModel.Mood.veryPleasant.rawValue : MoodModel.Mood.veryPleasant.getColor(),
            ])
            .frame(height: 300)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .task {
                statesOfMind = await readStateOfMindModel.getStateOfMindData()
            }
        }
    }
}

struct TotalEntriesOverview: View {
    @State private var readStateOfMindModel: ReadStateOfMindViewModel = .init()
    
    @State private var statesOfMind: [HKStateOfMind] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Entries")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(statesOfMind.count, format: .number)
                .font(.title2.bold())
            
            Chart {
                ForEach(statesOfMind, id: \.uuid) { stateOfMind in
                    let interpolatedMood = MoodModel.interpolatedMoodMapping(for: stateOfMind.valence)
                    return BarMark(
                        x: .value("Valence", stateOfMind.valence),
                        y: .value("Date", stateOfMind.endDate, unit: .day)
                    )
                    .foregroundStyle(by: .value("Shape Color", interpolatedMood.feeling))
                }
            }
            .chartForegroundStyleScale([
                MoodModel.Mood.veryUnpleasant.rawValue : MoodModel.Mood.veryUnpleasant.getColor(),
                MoodModel.Mood.unPleasant.rawValue : MoodModel.Mood.unPleasant.getColor(),
                MoodModel.Mood.slightlyUnpleasant.rawValue : MoodModel.Mood.slightlyUnpleasant.getColor(),
                MoodModel.Mood.neutral.rawValue : MoodModel.Mood.neutral.getColor(),
                MoodModel.Mood.slightlyPleasant.rawValue : MoodModel.Mood.slightlyPleasant.getColor(),
                MoodModel.Mood.pleasant.rawValue : MoodModel.Mood.pleasant.getColor(),
                MoodModel.Mood.veryPleasant.rawValue : MoodModel.Mood.veryPleasant.getColor(),
            ])
            .frame(height: 100)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .task {
                statesOfMind = await readStateOfMindModel.getStateOfMindData()
            }
        }
    }
}

