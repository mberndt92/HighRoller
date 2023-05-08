//
//  HighRollerResultView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct HighRollerResultView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 64))
    ]
    
    var result: HighRollerResult
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(result.results) { result in
                    result.image()
                        .frame(width: 64, height: 64)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct HighRollerResultView_Previews: PreviewProvider {
    static var previews: some View {
        HighRollerResultView(result: HighRollerResult.example)
    }
}
