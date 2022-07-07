//
//  Extensions.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import Foundation

extension String {
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur+=1
        }
        return nil
    }
}

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
