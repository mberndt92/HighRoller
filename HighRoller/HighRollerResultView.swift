//
//  HighRollerResultView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct HighRollerResultView: View {
    
    var columns = [
        GridItem(.adaptive(minimum: 64))
    ]
    
    var result: HighRollerResult
    var size: Double = 64
    
    init(result: HighRollerResult, size: Double = 64) {
        self.result = result
        self.size = size
        
        columns = [
            GridItem(.adaptive(minimum: size))
        ]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(result.results) { result in
                    result.image()
                        .frame(width: size, height: size)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HighRollerResultView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HighRollerResultView(result: HighRollerResult.example)
            Divider()
            HighRollerResultView(result: HighRollerResult.example, size: 48)
        }
    }
}
