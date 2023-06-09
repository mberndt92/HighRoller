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
                VStack(spacing: 25) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .shadow(radius: 10)
                            .frame(maxHeight: 64)
                        
                        Text("Total Eyes: \(viewModel.totalEyes)")
                            .font(.largeTitle)
                    }
                    if let result = viewModel.currentResult {
                        HighRollerResultView(result: result)
                            .frame(maxHeight: viewModel.resultViewHeight())
                    } else {
                        Image(systemName: viewModel.diceImageName())
                            .resizable()
                            .frame(width: 64, height: 64)
                    }
                    
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
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewModel.showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                
                ToolbarItem {
                    Button {
                        viewModel.showingResultHistory = true
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showingResultHistory) {
            ResultHistoryView(results: viewModel.results)
        }
        .sheet(isPresented: $viewModel.showingSettings) {
            SettingsView(dices: viewModel.diceConfig, useTint: viewModel.useTint) { dice, useTint in
                viewModel.set(dice)
                viewModel.set(useTint)
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    private func rollDice() {
        viewModel.rollDice()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
