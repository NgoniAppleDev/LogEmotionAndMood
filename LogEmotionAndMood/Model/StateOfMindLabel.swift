//
//  StateOfMindLabel.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 8/2/2025.
//

import Foundation

enum StateOfMindLabel: String, CaseIterable, Comparable {
    case amazed = "Amazed"
    case amused = "Amused"
    case angry = "Angry"
    case annoyed = "Annoyed"
    case anxious = "Anxious"
    case ashamed = "Ashamed"
    case brave = "Brave"
    case calm = "Calm"
    case confident = "Confident"
    case content = "Content"
    case disappointed = "Disappointed"
    case discouraged = "Discouraged"
    case disgusted = "Disgusted"
    case drained = "Drained"
    case embarrassed = "Embarrassed"
    case excited = "Excited"
    case frustrated = "Frustrated"
    case grateful = "Grateful"
    case guilty = "Guilty"
    case happy = "Happy"
    case hopeful = "Hopeful"
    case hopeless = "Hopeless"
    case indifferent = "Indifferent"
    case irritated = "Irritated"
    case jealous = "Jealous"
    case joyful = "Joyful"
    case lonely = "Lonely"
    case overwhelmed = "Overwhelmed"
    case passionate = "Passionate"
    case peaceful = "Peaceful"
    case proud = "Proud"
    case relieved = "Relieved"
    case sad = "Sad"
    case satisfied = "Satisfied"
    case scared = "Scared"
    case stressed = "Stressed"
    case surprised = "Surprised"
    case worried = "Worried"
    
    static func >(lhs: StateOfMindLabel, rhs: StateOfMindLabel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <(lhs: StateOfMindLabel, rhs: StateOfMindLabel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}
