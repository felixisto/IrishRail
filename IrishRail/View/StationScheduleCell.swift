//
//  StationScheduleCell.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import SwiftUI

struct StationScheduleCell: View {
    @ObservedObject var viewModel: StationScheduleCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                departureComponent
                
                Spacer()
                
                trainIcon
                
                Spacer()
                
                destinationComponent
            }
            
            bottomComponent
        }
        .padding()
        .alert(isPresented: $viewModel.showNotificationAlert) {
            if !viewModel.isNotificationPermissionDenied {
                return Alert(title: Text("Notification"),
                      message: !viewModel.isNotificationScheduled ? Text("Schedule reminder notification 15 minutes before departure?") : Text("Unschedule reminder notification?"),
                      primaryButton: .default(Text("Yes"), action: {
                        viewModel.scheduleOrUnscheduleNotification()
                      }),
                      secondaryButton: .default(Text("No")))
            } else {
                return Alert(title: Text("Permission not granted!"))
            }
        }
    }
    
    var departureComponent: some View {
        VStack {
            Text(viewModel.firstMovement.current.name)
                .font(.system(size: 18))
                .lineLimit(1)
                .frame(width: 86)
            
            Text(viewModel.firstMovement.current.departureAsString ?? "")
                .foregroundColor(Color.gray)
                .font(.system(size: 28))
        }
    }
    
    var trainIcon: some View {
        Image(uiImage: UIImage(named: "train")!)
            .resizable()
            .frame(width: 64, height: 64, alignment: .center)
    }
    
    var destinationComponent: some View {
        VStack {
            Text(viewModel.lastMovement.current.name)
                .font(.system(size: 18))
                .lineLimit(1)
                .frame(width: 86)
            
            Text(viewModel.lastMovement.current.arrivalAsString ?? "")
                .foregroundColor(Color.gray)
                .font(.system(size: 28))
        }
    }
    
    var bottomComponent: some View {
        HStack(spacing: 12) {
            HStack(spacing: 12) {
                Text("Train")
                    .font(.system(size: 20))
                
                VStack {
                    Text("Code")
                        .foregroundColor(Color.black)
                        .bold()
                    
                    Text(viewModel.model.trainInfo.code)
                        .font(.system(size: 13))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                
                VStack {
                    Text("Type")
                        .foregroundColor(Color.black)
                        .bold()
                    
                    Text(viewModel.model.trainInfo.kind)
                        .font(.system(size: 13))
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .minorPadding()
            .border(Color.green, width: 2)
            
            Image(uiImage: UIImage(named: !viewModel.isNotificationScheduled ? "alertRed" : "alertGreen")!)
                .resizable()
                .frame(width: 64, height: 48)
                .onTapGesture {
                    viewModel.showNotificationAlert = true
                }
        }
    }
}

struct StationScheduleCell_Previews: PreviewProvider {
    static var previews: some View {
        StationScheduleCell(viewModel: StationScheduleCellViewModel(model: schedule))
    }
    
    static var schedule: RailStationTrainSchedule {
        let time1 = Date()
        let time2 = Date()
        
        let trainInfo = TrainInfo(code: "A999", kind: "Standard")
        var result = RailStationTrainSchedule(trainInfo: trainInfo)
        let departure = RailStationMovement.Stop(name: "Arklow", trainCode: "", locationOrder: 0, arrival: nil, departure: time1)
        let dest = RailStationMovement.Stop(name: "Shankill", trainCode: "", locationOrder: 0, arrival: time2, departure: nil)
        result.movements.append(RailStationMovement(current: departure, destination: dest))
        result.movements.append(RailStationMovement(current: dest, destination: dest))
        return result
    }
}
