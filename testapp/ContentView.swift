//
//  ContentView.swift
//  testapp
//
//  Created by pomas on 26/06/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome to SwiftUI!")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Explore core iOS development concepts with these four mini-apps.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)

                    // Navigation Cards Grid/List
                    VStack(spacing: 16) {
                        NavigationCard(
                            title: "Counter Game",
                            subtitle: "State & User Interaction",
                            description: "Learn how to use @State variables and simple button triggers.",
                            iconName: "plus.circle.fill",
                            iconColor: .blue,
                            destination: CounterView()
                        )
                        
                        NavigationCard(
                            title: "Todo Manager",
                            subtitle: "Lists & Collections",
                            description: "Render dynamic lists, manage arrays, and delete items.",
                            iconName: "checklist",
                            iconColor: .green,
                            destination: TodoView()
                        )
                        
                        NavigationCard(
                            title: "RGB Color Mixer",
                            subtitle: "Bindings & Controls",
                            description: "See live bindings with Sliders and real-time color formatting.",
                            iconName: "slider.horizontal.3",
                            iconColor: .purple,
                            destination: ColorMixerView()
                        )
                        
                        NavigationCard(
                            title: "Quote Generator",
                            subtitle: "Networking & API Requests",
                            description: "Fetch dynamic JSON data using async/await and URLSession.",
                            iconName: "globe",
                            iconColor: .orange,
                            destination: QuoteGeneratorView()
                        )
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 30)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("SwiftUI Hub")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// Reusable card for dashboard navigation
struct NavigationCard<Destination: View>: View {
    let title: String
    let subtitle: String
    let description: String
    let iconName: String
    let iconColor: Color
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                // Icon container
                Image(systemName: iconName)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(iconColor.gradient)
                    .cornerRadius(12)
                    .shadow(color: iconColor.opacity(0.3), radius: 4, x: 0, y: 2)

                // Text details
                VStack(alignment: .leading, spacing: 4) {
                    Text(subtitle.uppercased())
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .foregroundColor(iconColor)
                    
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                // Chevron indicator
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle()) // Keeps standard button animations but allows custom styling
    }
}

#Preview {
    ContentView()
}
