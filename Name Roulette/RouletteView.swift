//
//  RouletteView.swift
//  Name Roulette
//
//  Created by Usman on 06/07/2022.
//

import SwiftUI

enum TeamTab {
    case unavailable
    case available
}

struct RouletteView: View {
    
    @StateObject private var viewModel = RouletteViewModel()
    @State private var teamTab: TeamTab = .available
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<16, id: \.self) { index in
                    Picker("", selection: $viewModel.lockRingStates[index]) {
                        ForEach(viewModel.lockRingValues, id: \.self) { alphabet in
                            Text(alphabet)
                        }
                    }
                    .pickerStyle(.wheel)
                    .animation(.spring())
                    .frame(maxWidth: 10)
                }
            }
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
                    List(viewModel.getTeam(), id: \.self) { person in
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
