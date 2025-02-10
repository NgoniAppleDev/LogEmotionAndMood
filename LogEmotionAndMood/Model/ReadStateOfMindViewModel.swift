//
//  ReadStateOfMindViewModel.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import SwiftUI
import Observation
import HealthKit


@Observable
class ReadStateOfMindViewModel {
    typealias StateOfMindForDay = [Date:[HKStateOfMind]]
    
    let healthKitManager = HealthKitManager()
    
    var selectedDate = Date() {
        didSet {
            updateMonthDays()
        }
    }
    private var savedStatesOfMind: [StateOfMindForDay] = [] {
        didSet {
            updateMonthDays()
        }
    }
    var monthDays = [Date]()
    
    var startOfMonth: Date = Date()
    var calendarStartPaddings: Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: startOfMonth)
        
        switch weekday {
        case 1:
            return 0
        case 2:
            return 1
        case 3:
            return 2
        case 4:
            return 3
        case 5:
            return 4
        case 6:
            return 5
        case 7:
            return 6
        default:
            return 0
        }
    }
    
    init() {
        Task {
            await self.fetch()
        }
        updateMonthDays()
    }
    
    func getStateOfMindData() async -> [HKStateOfMind] {
        return await healthKitManager.queryStateOfMindData()
    }
    
    func stateOfMindForDay(date: Date) -> StateOfMindForDay {
        return savedStatesOfMind.first(where: { $0.keys.contains(date.normalizedDate) }) ?? [date: []]
    }
    
    func areDatesOnSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func dayHasEmotions(state: StateOfMindForDay) -> Bool {
        for states in state {
            for stateOfMind in states.value {
                if stateOfMind.kind == .momentaryEmotion {
                    return true
                }
            }
        }
        
        return false
    }
    
    func dayHasDailyMood(state: StateOfMindForDay) -> Bool {
        for states in state {
            for stateOfMind in states.value {
                if stateOfMind.kind == .dailyMood {
                    return true
                }
            }
        }
        
        return false
    }
    
    func getDailyMoodForDay(state: StateOfMindForDay) -> HKStateOfMind? {
        for states in state.values {
            for stateOfMind in states {
                if stateOfMind.kind == .dailyMood { return stateOfMind }
            }
        }
        
        return nil
    }
    
    func getDailyMoodColor(state: StateOfMindForDay) -> Color {
        return MoodModel.moodMappings[
            getDailyMoodForDay(state: state)?.valence ?? 0
        ]?.faceColor ?? Color.clear
    }
    
    private func updateMonthDays() {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        self.startOfMonth = startOfMonth
        
        monthDays = range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
    
    func fetch() async {
        let statesForDay: [HKStateOfMind] = await self.getStateOfMindData()
        var finalData: Set<StateOfMindForDay> = []
        var uniqueDates: Set<Date> = []
        
        // get unique and normalized dates to use for keys of the dictionary(StateOfMindForDay)
        statesForDay.forEach { state_ForADay in
            uniqueDates.insert(state_ForADay.endDate.normalizedDate)
        }
        
        // create the StateOfMindForDay dictionary with the unique dates as keys
        uniqueDates.forEach { date in
            let statesForChosenDate = statesForDay.filter {
                self.areDatesOnSameDay($0.endDate.normalizedDate, date) || self.areDatesOnSameDay($0.startDate.normalizedDate, date)
            }
            let dict = [date: statesForChosenDate]
            if !finalData.contains(dict) { finalData.insert(dict) }
        }
        
        self.savedStatesOfMind = Array(finalData)
    }
}
