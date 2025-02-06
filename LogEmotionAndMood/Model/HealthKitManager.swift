//
//  HealthKitManager.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import Foundation
import HealthKit

@Observable
class HealthKitManager {
    let healthStore = HKHealthStore()
    
    var authenticated = false
    var trigger = false
    
    var errorMessage: String = ""
    var showError: Bool = false
    
    let allTypes: Set = [
        HKQuantityType.stateOfMindType(),
        HKQuantityType(.heartRate)
    ]
    
    func requestAuthorization() async {
        do {
            // check that Health Data is available on the device.
            if HKHealthStore.isHealthDataAvailable() {
                
                // Asynchronously request authorization to the data.
                try await healthStore.requestAuthorization(toShare: allTypes, read: allTypes)
                
                print("Succeeded to authorize health kit!")
                
            } else {
                handleError(error: "Health Data is not available on your device.")
            }
        } catch {
            handleError(error: error)
        }
    }
    
    func createSample(for kind: HKStateOfMind.Kind, valence: Double, labels: [HKStateOfMind.Label], associations: [HKStateOfMind.Association]) async ->
    HKStateOfMind {
        await self.requestAuthorization()
        
        return HKStateOfMind(date: Date(), kind: kind, valence: valence, labels: labels, associations: associations)
    }
    
    func save(sample: HKSample, healthStore: HKHealthStore) async {
        do {
            try await healthStore.save(sample)
            print("Succeeded to save sample!")
        }
        catch {
            print("Failed to save sample: \(error.localizedDescription)")
            handleError(error: error)
            // Handle error here.
        }
    }
    
    func queryStateOfMindData() {}

    
    func handleError(error: String) {
        errorMessage = error
        showError = true
    }
    
    func handleError(error: Error) {
        errorMessage = error.localizedDescription
        showError = true
    }
}
