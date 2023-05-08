//
//  ContentView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var results = HighRollerResults(results: [])
    
    @State private var currentResult: Int? = nil
    
    @State private var showingResultHistory = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 15) {
                    Image(systemName: diceImageName())
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
                        .onTapGesture {
                            showingResultHistory = true
                        }
                }
            }
        }
        .sheet(isPresented: $showingResultHistory) {
            ResultHistoryView(results: results)
        }
    }
    
    private func diceImageName() -> String {
        guard let currentResult else { return "questionmark" }
        
        return "die.face.\(currentResult)"
    }
    
    private func rollDice() {
        let dice = Dice.six
        let diceResult = DiceResult(dice: dice, result: dice.roll())
        let rollResult = HighRollerResult(results: [diceResult])
        withAnimation {
            currentResult = diceResult.result
        }
        results.results.append(rollResult)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
