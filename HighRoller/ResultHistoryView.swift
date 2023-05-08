//
//  ResultHistoryView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct ResultHistoryView: View {
    
    var results: HighRollerResults
    
    var body: some View {
        NavigationView {
            VStack {
                if results.results.isEmpty == false {
                    List {
                        ForEach(results.results.reversed()) { result in
                            VStack(alignment: .leading) {
                                Text("Total Eyes: ") + Text("\(result.totalEyes())")
                                    .font(.headline)
                                HighRollerResultHStackView(result: result, size: 48)       
                            }
                        }
                    }
                } else {
                    Text("Roll the dice to see results here")
                }
            }
            .navigationTitle("Result History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ResultHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ResultHistoryView(results: HighRollerResults.exampleEmpty)
            ResultHistoryView(results: HighRollerResults.example)
        }
        
    }
}
