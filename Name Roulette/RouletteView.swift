//
//  RouletteView.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import SwiftUI
import LockPickSwiftUI

enum TeamTab {
    case unavailable
    case available
}

struct RouletteView: View {
    
    @StateObject private var viewModel = RouletteViewModel()
    @State private var teamTab: TeamTab = .available
    
    var body: some View {
        VStack {
            LockPickRandomiserView(lockRingStates: $viewModel.lockRingStates, lockRingValues: $viewModel.lockRingValues)
            VStack {
                Picker("", selection: $teamTab) {
                    Text("All")
                    Text("Unavailable")
                }
                .onTapGesture {
                    teamTab = teamTab == .available ? .unavailable : .available
                }
                .pickerStyle(.segmented)
                .frame(height: 40)
                
                switch teamTab {
                case .unavailable:
                    List(viewModel.getUsed(), id: \.self) { person in
                        Text(person)
                    }
                case .available:
                    List(viewModel.getAll(), id: \.self) { person in
                        Text(person)
                    }
                }
            }
            HStack {
                Button("Refresh") {
                    viewModel.refreshData()
                }
                .foregroundColor(.primary)
                Spacer()
                Button("Save") {
                    
                }
                .foregroundColor(.primary)
            }
            .padding(.horizontal, 100)
            .padding([.bottom, .top], 10)
        }
    }
}

struct RouletteView_Previews: PreviewProvider {
    static var previews: some View {
        RouletteView()
            .environment(\.horizontalSizeClass, .compact)
    }
}
