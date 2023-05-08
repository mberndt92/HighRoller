//
//  ContentView+ViewModel.swift
//  HighRoller
//
//  Created by Maximilian Berndt on 2023/05/08.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var results = HighRollerResults(results: [])
        
        @Published var currentResult: Int? = nil
        
        @Published var showingResultHistory = false
        
//        @Published var contacts: [Contact] = []
//
//        // Image Picker related variables
//        @Published var image: Image?
//        @Published var showingImagePicker = false
//        @Published var inputImage: UIImage?
//
//        @Published var showingAddContactDialog = false
        
    }
}
