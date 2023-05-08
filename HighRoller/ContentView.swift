//
//  ContentView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results: [Int] = []
    
    @State private var currentResult: Int = 1
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 15) {
                    Image(systemName: "die.face.\(currentResult)")
                        .resizable()
                        .frame(width: 64, height: 64)
                    
                    Button("Roll dice", action: rollDice)
                        .padding()
                        .frame(maxWidth: 150)
                        .font(.headline)
                        .background(.regularMaterial)
                        .cornerRadius(25)
                        .shadow(radius: 10)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem {
                    Image(systemName: "clock.arrow.circlepath")
                }
            }
        }
    }
    
    private func rollDice() {
        withAnimation {
            currentResult = Int.random(in: 1...6)
        }
        results.append(currentResult)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
