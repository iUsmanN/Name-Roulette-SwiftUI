//
//  NameGenerator.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import Foundation

public typealias CharacterCount = (Character, Int)

public class LockPickDataGenerator {
    static let shared = LockPickDataGenerator()
    private var team: [String] = []
    private var used: [String] = []
    
    /// Generates the data for the picker. Always call this first.
    /// - Parameters:
    ///   - allTeam: "All words"
    ///   - unavailableTeam: "Unavailable/Used words"
    public func setup(allTeam: [String], unavailableTeam: [String]){
        team = allTeam
        used = unavailableTeam
    }
    
    /// Returns the remaining members that have not been used before
    private func remainingMembers() -> [String] {
        guard !used.isEmpty else { return team }
        return team.filter { member in !used.contains(member)}
    }
    
    /// Returns a random member from the available members
    /// - Returns: <#description#>
    public func getRandomMember() -> String {
        let member = remainingMembers().randomElement() ?? "ERR"
        return member
    }
    
    /// Returns the character counts of the unique characters present in a word
    /// - Parameter member: Target word
    /// - Returns: <#description#>
    public func randomMemberCharacterCounts(member: String) -> [(Character, Int)] {
        return characterCounts().filter { characterCount in
            member.contains(characterCount.0)
        }
    }
    
    /// Updates the number of words that have already been used
    /// - Parameter usedInput: <#usedInput description#>
    public func updateUsed(usedInput: [String]) {
        used = usedInput
    }
}

extension LockPickDataGenerator {
    
    private func characterCounts() -> [(Character, Int)] {
        var counts = [CharacterCount]()
        let uniqueCharacters = characterUnion()
        let allCharacters = allCharacters()
        for character in uniqueCharacters {
            counts.append((character, allCharacters.filter({ $0 == character}).count))
        }
        counts.sort(by: {$0.1 > $1.1})
        return counts
    }
    
    private func characterUnion() -> Set<Character> {
        var set = Set<Character>()
        for member in remainingMembers() {
            set.formUnion(member)
        }
        return set
    }
    
    private func allCharacters() -> [Character] {
        var characters = [Character]()
        for member in remainingMembers() {
            characters.append(contentsOf: member)
        }
        return characters
    }
}
