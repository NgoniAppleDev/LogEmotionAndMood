//
//  LogEmotionAndMoodApp.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI
import HealthKitUI
import HealthKit
import os

private let logger = Logger(
    subsystem: "com.ngonikatsidzira.LogEmotionAndMood",
    category: "Mental Health App"
)

@main
struct LogEmotionAndMoodApp: App {
    @State private var healthKitManager: HealthKitManager = .init()
    @State var logStateOfMindModel: LogStateOfMindViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView(enabled: $healthKitManager.authenticated, logStateOfMindModel: $logStateOfMindModel)
                .healthDataAccessRequest(
                    store: healthKitManager.healthStore,
                    shareTypes: healthKitManager.allTypes,
                    readTypes: healthKitManager.allTypes,
                    trigger: healthKitManager.trigger
                ) { result in
                    switch result {
                    case .success(_):
                        healthKitManager.authenticated = true
                    case .failure(let failure):
                        logger.debug("an error occurred while authenticating: \(failure)")
                    }
                    logger.debug("Authentication Complete.")
                }
                .task {
                    healthKitManager.trigger.toggle()
                }
        }
    }
}
