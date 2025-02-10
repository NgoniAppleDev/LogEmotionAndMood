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
    struct StateForMindForDay: Identifiable {
        let id = UUID()
        let stateOfMind: HKStateOfMind?
        let hasDailyMood: Bool
        let hasEmotions: Bool
        var allItems: [[Date: HKStateOfMind]]? = nil
    }
    
    let healthKitManager = HealthKitManager()
    
    var selectedDate = Date() {
        didSet {
            updateMonthDays()
        }
    }
    private var savedStatesOfMind: [Date:HKStateOfMind] = [:]
    var monthDays = [Date]()
    var calendarStartPaddings: Int {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: selectedDate)
        
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
    
    func areDatesOnSameDay(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func stateOfMindForDay(date: Date) -> StateForMindForDay {
        let items = savedStatesOfMind.filter { self.areDatesOnSameDay($1.endDate.normalizedDate, date.normalizedDate) }
        
        let dailyMood = items.first(where: { $1.kind == .dailyMood })
        
        let hasDailyMood = dayHasMood(states: items)
        let hasEmotions = dayHasEmotions(states: items)
        
        return StateForMindForDay(stateOfMind: dailyMood?.value, hasDailyMood: hasDailyMood, hasEmotions: hasEmotions, allItems: [items])
    }
    
    private func dayHasEmotions(states: [Date: HKStateOfMind]) -> Bool {
        for (_, value) in states {
            if value.kind == .momentaryEmotion {
                return true
            }
        }
        
        return false
    }
    
    private func dayHasMood(states: [Date: HKStateOfMind]) -> Bool {
        let item = states.first(where: { $1.kind == .dailyMood })
        return item != nil
    }
    
    private func updateMonthDays() {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDate))!
        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!
        
        monthDays = range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }
    
    func fetch() async {
        let states: [HKStateOfMind] = await self.getStateOfMindData()
        
        states.forEach { stateOfMind in
            let data = Dictionary(uniqueKeysWithValues: states.map { ($0.endDate, $0) })
            self.savedStatesOfMind = data
        }
    }
}
