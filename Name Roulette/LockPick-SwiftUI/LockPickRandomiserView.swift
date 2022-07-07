//
//  LockPickRandomiserView.swift
//  Name Roulette
//
//  Created by Usman on 07/07/2022.
//

import SwiftUI

struct LockPickRandomiserView: View {
    var body: some View {
//        HStack {
//            ForEach(0..<16, id: \.self) { index in
//                Picker("", selection: $viewModel.alphabetStates[index]) {
//                    ForEach(viewModel.alphabets, id: \.self) { alphabet in
//                        Text(alphabet)
//                    }
//                }
//                .pickerStyle(.wheel)
//                .animation(.spring())
//                .frame(maxWidth: 10)
//            }
//        }
        Text("A")
    }
}

struct LockPickRandomiserView_Previews: PreviewProvider {
    static var previews: some View {
        LockPickRandomiserView()
    }
}
