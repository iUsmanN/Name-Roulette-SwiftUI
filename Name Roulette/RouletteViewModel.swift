//
//  RouletteViewModel.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import Foundation
import SwiftUI

class RouletteViewModel: NSObject, ObservableObject, LockPickRandomiserDataSource {
    
    @Published var randomMember = ""
    @Published var randomMemberCharacterCounts: [CharacterCount] = []
    @Published var lockRingStates = ["t","h","e"," ", "g","u","a","r","d","i","a","n"," ","","",""]
    @Published var lockRingValues = ["x", "p", "e", "o", "j", "m", " ", "i", "b", "z", "a", "y", "g", "l", "q", "d", "r", "v", "h", "s", "c", "w", "f", "t", "k", "n", "u"]
    
    internal var allWords = [
        "usman nazir     ",
        "taha amini      ",
        "andrew magee    ",
        "dana dramowicz  ",
        "ben sullivan    ",
        "benjamin briggs ",
        "oliver stowell  ",
        "simone smith    ",
        "tom king        ",
        "zachary burgess ",
        "aoife mclaughlin",
        "daniel okoronkwo"
    ]
    
    internal var usedWords: [String] = [
        "usman nazir     "
    ]
    
    var steps = 0
    @Published var determined = false
    
    override init() {
        super.init()
        loadStates()
        LockPickDataGenerator.shared.setup(allTeam: allWords, unavailableTeam: usedWords)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.updateLockRingStates()
        }
    }
    
    func refreshData() {
        refreshLockData()
    }
}

extension RouletteViewModel {
    
    private func saveStates() {
        print("Save States")
        // save team
        // save used
    }
    
    private func loadStates() {
        print("Load States")
        // load team
        // load used
    }
}
