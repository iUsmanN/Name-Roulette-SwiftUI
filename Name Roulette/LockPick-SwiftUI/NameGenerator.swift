//
//  NameGenerator.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import Foundation

typealias CharacterCount = (Character, Int)

class LockPickDataGenerator {
    static let shared = LockPickDataGenerator()
    private var team: [String] = []
    private var used: [String] = []
    
    func setup(allTeam: [String], unavailableTeam: [String]){
        team = allTeam
        used = unavailableTeam
    }
    
    private func remainingMembers() -> [String] {
        guard !used.isEmpty else { return team }
        return team.filter { member in !used.contains(member)}
    }
    
    func getRandomMember() -> String {
        let member = remainingMembers().randomElement() ?? "ERR"
        return member
    }
    
    func randomMemberCharacterCounts(member: String) -> [(Character, Int)] {
        return characterCounts().filter { characterCount in
            member.contains(characterCount.0)
        }
    }
    
    func updateUsed(usedInput: [String]) {
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
