//
//  LockPickRandomiserDataSource.swift
//  Name Roulette
//
//  Created by Usman on 07/07/2022.
//

import Foundation

public protocol LockPickRandomiserDataSource: NSObject {
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
    
    /// Refreshes the lock state with a new random word.
    public func refreshLockData() {
        randomMember = LockPickDataGenerator.shared.getRandomMember()
        randomMemberCharacterCounts = LockPickDataGenerator.shared.randomMemberCharacterCounts(member: randomMember)
        updateLockRingStates()
    }
    
    /// Updates the states of the rings.
    public func updateLockRingStates() {
        steps = randomMemberCharacterCounts.count
        guard !randomMemberCharacterCounts.isEmpty else { return }
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
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
    
    public func getAll() -> [String] {
        return allWords
    }
    
    public func getUsed() -> [String] {
        return usedWords
    }
}
