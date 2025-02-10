//
//  ReadStateOfMindData.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 6/2/2025.
//

import SwiftUI

struct ClickedDate: Identifiable {
    let id = UUID()
    var date: Date
}

struct ReadStateOfMindData: View {
    @State var readStateOfMindModel: ReadStateOfMindViewModel = .init()
    @State private var clickedDate: ClickedDate?
    
    var body: some View {
        ZStackWithGradient {
            ScrollView(showsIndicators: false) {
                VStack {
                    TopBigDateView(readStateOfMindModel: $readStateOfMindModel)
                    
                    TopActionButtons(
                        readStateOfMindModel: $readStateOfMindModel
                    )
                    
                    StatesOfMindCalendarView(
                        readStateOfMindModel: $readStateOfMindModel,
                        clickedDate: $clickedDate
                    )
                    
                    BottomContent()
                }
            }
            .padding()
        }
        .refreshable {
            let _ = await readStateOfMindModel.getStateOfMindData()
            withAnimation {
                readStateOfMindModel.selectedDate = Date()
            }
        }
        .task{
            let _ = await readStateOfMindModel.getStateOfMindData()
        }
        .sheet(item: $clickedDate) { date in
            NavigationStack {
                StateOfMindForADayView(readStateOfMindModel: readStateOfMindModel, clickedDate: date)
            }
        }
        .navigationTitle("Read Data")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ReadStateOfMindData(readStateOfMindModel: ReadStateOfMindViewModel())
    }
}

struct DaysOfWeekView: View {
    let daysOfWeek = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    
    var body: some View {
        ForEach(daysOfWeek, id: \.self) { dayOfWeek in
            Text(dayOfWeek)
                .font(.callout.weight(.bold))
                .padding(.vertical)
        }
    }
}

struct DaysOfMonthView: View {
    @Binding var readStateOfMindModel: ReadStateOfMindViewModel
    @Binding var clickedDate: ClickedDate?
    
    var body: some View {
        ForEach(readStateOfMindModel.monthDays, id: \.self) { dayOfMonth in
            let stateOfMindForDay = readStateOfMindModel.stateOfMindForDay(date: dayOfMonth)
            let today = Date().normalizedDate
            
            Button {
                clickedDate = ClickedDate(date: dayOfMonth)
            } label: {
                VStack(spacing: 5) {
                    ZStack {
                        if let stateForDay = stateOfMindForDay.stateOfMind, stateForDay.kind == .dailyMood {
                            Circle()
                                .fill(MoodModel.moodMappings[stateForDay.valence]?.faceColor ?? Color.clear)
                                .frame(width: 35, height: 35)
                        } else {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 35, height: 35)
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color(.tertiaryLabel), lineWidth: (dayOfMonth > today) ? 0 : 0.5)
                                }
                        }
                        Text(Calendar.current.component(.day, from: dayOfMonth).description)
                            .font(.callout.weight(.bold))
                            .foregroundColor((stateOfMindForDay.stateOfMind != nil && stateOfMindForDay.hasDailyMood) ? .white : (dayOfMonth > today) ? Color(.tertiaryLabel) : .primary)
                            .contentTransition(.numericText())
                    }
                    if stateOfMindForDay.hasEmotions {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 5, height: 5)
                    } else {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .opacity(0)
                            .scaledToFit()
                            .frame(width: 5, height: 5)
                    }
                }
                .padding(.vertical, 4)
            }
            .disabled(dayOfMonth > today)
        }
    }
}

struct TopActionButtons: View {
    @Binding var readStateOfMindModel: ReadStateOfMindViewModel
    
    var body: some View {
        HStack {
            Button{
                withAnimation {
                    readStateOfMindModel.selectedDate = Date()
                }
            } label: {
                Text("Today")
                    .font(.headline)
                    .padding(12.0)
                    .frame(maxWidth: .infinity)
                    .contentShape(RoundedRectangle(cornerRadius: 12.0))
            }
            .background(Color(.systemBlue), in: .rect(cornerRadius: 12.0))
            
            Spacer()
            
//            Button{} label: {
//                Text("Log")
//                    .padding(12.0)
//                    .frame(maxWidth: .infinity)
//                    .contentShape(RoundedRectangle(cornerRadius: 12.0))
//            }
//            .background(Color(.systemBlue), in: .rect(cornerRadius: 12.0))
        }
        .font(.footnote.weight(.semibold))
        .foregroundStyle(.white)
        .padding(.vertical)
    }
}

struct TopBigDateView: View {
    @Binding var readStateOfMindModel: ReadStateOfMindViewModel
    
    var body: some View {
        HStack {
            Text(readStateOfMindModel.selectedDate, format: .dateTime.month(.wide).year())
                .font(.title.weight(.semibold))
                .contentTransition(.numericText())
            
            Spacer()
            
            HStack(spacing: 35) {
                Button {
                    withAnimation {
                        readStateOfMindModel.selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: readStateOfMindModel.selectedDate)!
                    }
                } label: {
                    Image(systemName: "chevron.left")
                }
                
                Button {
                    withAnimation {
                        readStateOfMindModel.selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: readStateOfMindModel.selectedDate)!
                    }
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .buttonStyle(.plain)
            .fontWeight(.bold)
        }
        .padding(.bottom)
    }
}

struct StatesOfMindCalendarView: View {
    @Binding var readStateOfMindModel: ReadStateOfMindViewModel
    @Binding var clickedDate: ClickedDate?
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                DaysOfWeekView()
                
                ForEach(1...readStateOfMindModel.calendarStartPaddings, id: \.self) {index in
                    Text("")
                }
                
                DaysOfMonthView(
                    readStateOfMindModel: $readStateOfMindModel,
                    clickedDate: $clickedDate
                )
            }
            .padding()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12.0)
                .strokeBorder(.tertiary)
        }
    }
}

struct BottomContent: View {
    var body: some View {
        VStack {
            ContentUnavailableView {
                Label("No Entry", systemImage: "calendar.badge.minus")
                    .labelStyle(.iconOnly)
                    .font(.system(size: 40))
                    .foregroundStyle(.secondary)
            } description: {
                Text("No Entry")
                    .font(.title2)
                    .padding(.top, 10.0)
            }
        }
        .padding(.vertical)
    }
}



