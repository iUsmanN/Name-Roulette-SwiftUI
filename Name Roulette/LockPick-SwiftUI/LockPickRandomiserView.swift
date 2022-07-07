//
//  LockPickRandomiserView.swift
//  Name Roulette
//
//  Created by Usman on 07/07/2022.
//

import SwiftUI

struct LockPickRandomiserView: View {
    
    // Current values being shown
    @Binding private var lockRingStates: [String]// = ["x", "x", "x"]
    
    // All possible values of the rings
    @Binding private var lockRingValues: [String]// = ["x", "y", "z"]
    
    var body: some View {
        HStack {
            ForEach(0..<lockRingStates.count, id: \.self) { index in
                Picker("", selection: $lockRingStates[index]) {
                    ForEach(lockRingValues, id: \.self) { alphabet in
                        Text(alphabet)
                    }
                }
                .pickerStyle(.wheel)
                .animation(.spring())
                .frame(maxWidth: 10)
            }
        }
        .background(.red)
    }
}

//struct LockPickRandomiserView_Previews: PreviewProvider {
//    @State private var testStates: [String] =
//    @State private var testStates: [String] =
//    static var previews: some View {
//        LockPickRandomiserView(lockRingStates: , lockRingValues: ["x","y"])
//    }
//}
