//
//  LockPickRandomiserDataSource.swift
//  Name Roulette
//
//  Created by Usman on 07/07/2022.
//

import Foundation

protocol LockPickRandomiserDataSource: NSObject {
    var randomMember: String {get set}
    var randomMemberCharacterCounts: [CharacterCount] {get set}
    
    var lockRingStates: [String] {get set}
    var lockRingValues: [String] {get set}
    var allWords: [String] {get set}
    var usedWords: [String] {get set}
    
    func updateLockRingStates()
    func refreshLockData()
    
    func getAll() -> [String]
    func getUsed() -> [String]
    
    var steps: Int {get set}
}

extension LockPickRandomiserDataSource {
    
    func refreshLockData() {
        randomMember = LockPickDataGenerator.shared.getRandomMember()
        randomMemberCharacterCounts = LockPickDataGenerator.shared.randomMemberCharacterCounts(member: randomMember)
        updateLockRingStates()
    }
    
    func updateLockRingStates() {
        steps = randomMemberCharacterCounts.count
        guard !randomMemberCharacterCounts.isEmpty else { return }
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: true) { timer in
            guard min(5, self.steps) > 0 else { timer.invalidate(); return }
            let characterCount = self.randomMemberCharacterCounts.removeFirst()
            let indexes = self.randomMember.enumerated().filter({ $0.element == characterCount.0 }).map({ $0.offset })
            for i in indexes {
                DispatchQueue.main.async {
                    self.lockRingStates[i] = "\(characterCount.0)"
                }
            }
            self.steps -= 1
        }
        
        // Uncomment for parallel scrolling
//        for i in 0..<randomMember.count {
//            alphabetStates[i] = "\(randomMember.characterAtIndex(index: i)!)"
//        }
    }
    
    func getAll() -> [String] {
        return allWords
    }
    
    func getUsed() -> [String] {
        return usedWords
    }
}
