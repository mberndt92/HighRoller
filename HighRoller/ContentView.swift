//
//  ContentView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
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
                            viewModel.showingResultHistory = true
                        }
                }
            }
        }
        .sheet(isPresented: $viewModel.showingResultHistory) {
            ResultHistoryView(results: viewModel.results)
        }
    }
    
    private func diceImageName() -> String {
        guard let currentResult = viewModel.currentResult else { return "questionmark.square" }
        
        return "die.face.\(currentResult)"
    }
    
    private func rollDice() {
        let dice = Dice.six
        let diceResult = DiceResult(dice: dice, result: dice.roll())
        let rollResult = HighRollerResult(results: [diceResult])
        withAnimation {
            viewModel.currentResult = diceResult.result
        }
        viewModel.results.results.append(rollResult)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
