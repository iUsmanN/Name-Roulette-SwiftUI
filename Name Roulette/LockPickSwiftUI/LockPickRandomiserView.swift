//
//  LockPickRandomiserView.swift
//  Name Roulette
//
//  Created by Usman on 07/07/2022.
//

import SwiftUI

public struct LockPickRandomiserView: View {
    
    // Current values being shown
    @Binding var lockRingStates: [String]// = ["x", "x", "x"]
    
    // All possible values of the rings
    @Binding var lockRingValues: [String]// = ["x", "y", "z"]
    
    public var body: some View {
        HStack {
            ForEach(0..<lockRingStates.count, id: \.self) { index in
                Picker("", selection: $lockRingStates[index]) {
                    ForEach(lockRingValues, id: \.self) { alphabet in
                        Text(alphabet)
                    }
                }
                .pickerStyle(.wheel)
                .animation(.spring())
                .frame(maxWidth: 12)
            }
        }
    }
}
