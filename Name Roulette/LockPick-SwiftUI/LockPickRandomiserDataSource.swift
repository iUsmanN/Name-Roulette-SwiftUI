//
//  LockPickRandomiserDataSource.swift
//  Name Roulette
//
//  Created by Usman on 07/07/2022.
//

import Foundation

protocol LockPickRandomiserDataSource {
    var lockRingStates: [String] {get set}
    var lockRingValues: [String] {get set}
    var allWords: [String] {get set}
    var usedWords: [String] {get set}
    
    func updateLockRingStates() {
}
