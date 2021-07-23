//
//  PrimaryView.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import SwiftUI
import Resolver

struct PrimaryView: View {
    @ObservedObject var viewModel: PrimaryViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 14) {
            Text("Where to?")
                .font(.system(size: 22))
            
            StationStopTextField(header: "From", titleKey: "Departure", text: $viewModel.departureValue, suggestions: $viewModel.stationSuggestions)
                .zIndex(10)
            
            StationStopTextField(header: "To", titleKey: "Destination", text: $viewModel.destinationValue, suggestions: $viewModel.stationSuggestions)
                .zIndex(9)
            
            scheduleButton
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Irish Rail", displayMode: .inline)
        .onAppear {
            viewModel.refreshData()
        }
    }
    
    var scheduleButton: some View {
        NavigationLink(
            destination: NavigationLazyView(stationScheduleView),
            isActive: $viewModel.scheduleScreenIsOpened) {
            Button("Schedule >") {
                viewModel.scheduleScreenIsOpened = true
            }
            .disabled(!viewModel.canProceed)
            .frame(width: 128, height: 32, alignment: .center)
            .foregroundColor(.white)
            .background(viewModel.canProceed ? Color.yellow : Color.gray)
        }
        .disabled(!viewModel.canProceed)
    }
    
    var stationScheduleView: some View {
        StationScheduleView(viewModel: StationScheduleViewModel(departureStation: viewModel.departureValue, destinationStation: viewModel.destinationValue, scheduleScreenIsOpened: $viewModel.scheduleScreenIsOpened))
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            primaryViewDefault
            
            primaryViewPopulated
        }
    }
    
    static var primaryViewDefault: PrimaryView {
        let viewModel = PrimaryViewModel()
        let view = PrimaryView(viewModel: viewModel)
        return view
    }
    
    static var primaryViewPopulated: PrimaryView {
        Resolver.register {
            RecentlySearchedStationsRepositoryDummy() as RecentlySearchedStationsRepository
        }
        
        let viewModel = PrimaryViewModel()
        viewModel.departureValue = "Arklow"
        viewModel.destinationValue = "Shankill"
        let view = PrimaryView(viewModel: viewModel)
        return view
    }
}
