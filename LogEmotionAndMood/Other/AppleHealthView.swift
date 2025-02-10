//
//  AppleHealthView.swift
//  LogEmotionAndMood
//
//  Created by Ngoni Katsidzira  on 5/2/2025.
//

import SwiftUI

struct AppleHealthView: View {
    @Binding var enabled: Bool
    
    var body: some View {
            ScrollView {
                VStack(spacing: 10.0) {
                    Image(.appleHealthCare)
                    Text("We would like to access Apple Health")
                        .font(.title3.weight(.bold))
                    
                    Text("Allow Yoga to connect to Apple Health in order to track your activity data.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                
                Toggle("Connect to Apple Health", isOn: $enabled)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color(.tertiarySystemFill), in: .rect(cornerRadius: 12.0))
                    .padding(.vertical, 20)
                
                VStack {
                    Text("If the data doesn't sync with Apple Health, do the following:")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .padding(.bottom)
                    
                    HStack(spacing: 20) {
                        Image(.appleHealthCare)
                            .resizable().scaledToFit()
                            .frame(width: 50, height: 50)
                        Button {
                            openHealthApp()
                        } label: {
                            Text("Go to Apple Health")
                                .underline()
                                .foregroundColor(.accentColor)
                                .font(.callout)
                        }
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "person.crop.circle")
                            .resizable().scaledToFit()
                            .frame(width: 30, height: 30)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.secondary)
                        HStack {
                            Text("Open your")
                                .font(.callout)
                            Text("Profile")
                                .font(.headline)
                        }
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "square.3.stack.3d")
                            .resizable().scaledToFit()
                            .frame(width: 30, height: 30)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.secondary)
                        HStack {
                            Text("Clicks")
                                .font(.callout)
                            Text("Apps")
                                .font(.headline)
                            Text("under")
                            Text("Privacy")
                                .font(.headline)
                        }
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "doc.append")
                            .resizable().scaledToFit()
                            .frame(width: 30, height: 30)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.secondary)
                        HStack {
                            Text("Find <your_app> and turn on the category you want to sync.")
                                .font(.callout)
                                .lineLimit(-1)
                        }
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Apple Health")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func openHealthApp() {
            if let url = URL(string: "x-apple-health://") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    print("Apple Health app is not available")
                }
            }
        }
}

#Preview {
    NavigationStack {
        AppleHealthView(enabled: .constant(false))
    }
}
