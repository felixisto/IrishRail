//
//  StationScheduleView.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import SwiftUI

struct StationScheduleView: View {
    @ObservedObject var viewModel: StationScheduleViewModel
    
    var body: some View {
        defaultBody.minorPadding()
        .navigationBarTitle("\(viewModel.departureStation)", displayMode: .inline)
        .onAppear {
            viewModel.refreshData()
        }
    }
    
    var defaultBody: some View {
        VStack {
            if !viewModel.schedule.isEmpty {
                ScrollView {
                    loadedContents
                }
            } else {
                unloadedContents
            }
        }
    }
    
    var loadedContents: some View {
        LazyVStack {
            ForEach(viewModel.schedule.schedule) { item in
                StationScheduleCell(viewModel: StationScheduleCellViewModel(model: item))
            }
        }
    }
    
    var unloadedContents: some View {
        GeometryReader { geo in
            if viewModel.isLoaded {
                Text("No trains scheduled in the next \(APIStationSchedule.NUM_MINS) minutes")
            } else {
                ProgressView()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            }
        }
        .frame(width: nil, height: nil, alignment: .center)
    }
}

struct StationScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StationScheduleView(viewModel: viewModel)
            
            StationScheduleView(viewModel: blankViewModel)
        }
    }
    
    static var blankViewModel: StationScheduleViewModel {
        StationScheduleViewModel(departureStation: "London", destinationStation: "Moscow", scheduleScreenIsOpened: .constant(true))
    }
    
    static var viewModel: StationScheduleViewModel {
        let result = blankViewModel
        result.isLoaded = true
        
        let time1 = Date()
        let time2 = Date()
        
        let trainInfo1 = TrainInfo(code: "A999", kind: "Standard")
        var schedule1 = RailStationTrainSchedule(trainInfo: trainInfo1)
        
        let departure1 = RailStationMovement.Stop(name: "Arklow", trainCode: "", locationOrder: 0, arrival: nil, departure: time1)
        let dest1 = RailStationMovement.Stop(name: "Shankill", trainCode: "", locationOrder: 0, arrival: time2, departure: nil)
        schedule1.movements.append(RailStationMovement(current: departure1, destination: dest1))
        schedule1.movements.append(RailStationMovement(current: dest1, destination: dest1))
        
        let trainInfo2 = TrainInfo(code: "B666", kind: "DART")
        var schedule2 = RailStationTrainSchedule(trainInfo: trainInfo2)
        
        let departure2 = RailStationMovement.Stop(name: "London", trainCode: "", locationOrder: 0, arrival: nil, departure: time2)
        let dest2 = RailStationMovement.Stop(name: "Berlin", trainCode: "", locationOrder: 0, arrival: time1, departure: nil)
        schedule2.movements.append(RailStationMovement(current: departure2, destination: dest2))
        schedule2.movements.append(RailStationMovement(current: dest2, destination: dest2))
        
        result.schedule = RailStationSchedule(schedule: [schedule1, schedule2])
        
        return result
    }
}
