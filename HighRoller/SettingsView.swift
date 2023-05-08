//
//  SettingsView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // Preferring to use incorrect grammar than to use DIE everywhere and not understand the context immediately.
    @State private var dices: [Dice: Int] = [:]
    
    @State private var useTint = false
    
    private var save: ([Dice], Bool) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Use tint to differentiate dice", isOn: $useTint)
                ForEach(Dice.allCases, id: \.rawValue) { dice in
                    HStack(spacing: 15) {
                        DiceResult(dice: dice, result: dice.rawValue, useTint: useTint).image()
                            .frame(width: 64, height: 64)

                        Stepper("x \(dices[dice]!)") {
                            increment(dice: dice)
                        } onDecrement: {
                            decrement(dice: dice)
                        } onEditingChanged: { change in
                            //
                        }
                        .font(.headline)

                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem {
                    Button("Save", action: onSave)
                }
            }
        }
    }
    
    init(dices: [Dice : Int], useTint: Bool, onSave: @escaping ([Dice], Bool) -> Void) {
        // Leaving a comment here: self.save seems to require to be listed first otherwise an error appears
        self.save = onSave
        _dices = State(initialValue: dices)
        _useTint = State(initialValue: useTint)
        
        if self.dices[.four] == nil { self.dices[.four] = 0 }
        if self.dices[.six] == nil { self.dices[.six] = 0 }
        if self.dices[.eight] == nil { self.dices[.eight] = 0 }
        if self.dices[.ten] == nil { self.dices[.ten] = 0 }
        if self.dices[.twelve] == nil { self.dices[.twelve] = 0 }
        if self.dices[.twenty] == nil { self.dices[.twenty] = 0 }
        if self.dices[.hundred] == nil { self.dices[.hundred] = 0 }
    }
    
    private func onSave() {
        var allDice: [Dice] = []

        for (dice, value) in dices  {
            for _ in 0..<value {
                allDice.append(Dice(rawValue: dice.rawValue)!)
            }
        }

        save(allDice, useTint)
        dismiss()
    }
    
    private func increment(dice: Dice) {
        dices[dice]! += 1
    }
    
    private func decrement(dice: Dice) {
        guard dices[dice]! > 0 else { return }
        
        dices[dice]! -= 1
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(dices: Dice.emptyDictionary, useTint: true, onSave: { _, _ in })
    }
}
