//
//  HighRolerResultHStackView.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import SwiftUI

struct HighRollerResultHStackView: View {
    
    var result: HighRollerResult
    var size: Double = 64
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(result.results) { result in
                    result.image(font: .headline)
                        .frame(width: size, height: size)
                }
            }
        }
    }
}


struct HighRolerResultHStackView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HighRollerResultHStackView(result: HighRollerResult.example)
            Divider()
            HighRollerResultHStackView(result: HighRollerResult.example, size: 48)
        }
    }
}
