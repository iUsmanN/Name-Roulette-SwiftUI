//
//  RouletteViewModel.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import Foundation
import SwiftUI

class RouletteViewModel: ObservableObject {
    @Published var randomMember = ""
    @Published var randomMemberCharacterCounts: [CharacterCount] = []
    @Published var lockRingStates = ["t","h","e","", "g","u","a","r","d","i","a","n"," ","","","","","","","","","","","","","","","",""]
    @Published var lockRingValues = ["x", "p", "e", "o", "j", "m", " ", "i", "b", "z", "a", "y", "g", "l", "q", "d", "r", "v", "h", "s", "c", "w", "f", "t", "k", "n", "u"]
    
    private var allWords = [
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
    
    private var usedWords: [String] = [
        "usman nazir     "
    ]
    
    var steps = 0
    @Published var determined = false
    
    init() {
        loadStates()
        LockPickDataGenerator.shared.setup(allTeam: allWords, unavailableTeam: usedWords)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
//            self.randomMember = "the guardian  "
            self.updateLockRingStates()
        }
    }
    
    func refreshData() {
        determined = false
        randomMember = LockPickDataGenerator.shared.getRandomMember()
        randomMemberCharacterCounts = LockPickDataGenerator.shared.randomMemberCharacterCounts(member: randomMember)
        updateLockRingStates()
    }
    
    func updateLockRingStates() {
        steps = randomMemberCharacterCounts.count
        guard !randomMemberCharacterCounts.isEmpty else { return }
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { timer in
            guard min(5, self.steps) > 0 else { self.determined = true; timer.invalidate(); return }
            let characterCount = self.randomMemberCharacterCounts.removeFirst()
            let indexes = self.randomMember.enumerated().filter({ $0.element == characterCount.0 }).map({ $0.offset })
            for i in indexes {
                DispatchQueue.main.async {
                    self.lockRingStates[i] = "\(characterCount.0)"
                }
            }
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            self.steps -= 1
        }
        
        // Uncomment for parallel scrolling
//        for i in 0..<randomMember.count {
//            alphabetStates[i] = "\(randomMember.characterAtIndex(index: i)!)"
//        }
    }
    
    func getTeam() -> [String] {
        return allWords
    }
    
    func getUsed() -> [String] {
        return usedWords
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
