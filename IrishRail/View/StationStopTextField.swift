//
//  StationStopTextField.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import Foundation
import SwiftUI
import Resolver

struct StationStopTextField: View {
    public static let HEADER_WIDTH: CGFloat = 48
    public static let FIELD_HEIGHT: CGFloat = 40
    
    let header: String
    let titleKey: LocalizedStringKey
    @Binding var text: String
    let suggestions: Binding<[RailStation]>
    
    @State var isBeingEdited = false
    
    @Injected var suggestionFilter: StationSuggestionFilter
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 4) {
                Text(header)
                    .frame(width: Self.HEADER_WIDTH)
                
                TextField(titleKey, text: $text, onEditingChanged: { (editingChanged) in
                    isBeingEdited = editingChanged
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(!isEnteredStationInvalid ? Color.black : Color.red)
                .frame(height: Self.FIELD_HEIGHT)
                .overlay(suggestionsView, alignment: .topLeading)
            }
        }
    }
    
    var suggestionsView: some View {
        VStack {
            Spacer()
                .frame(height: Self.FIELD_HEIGHT)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 4) {
                    ForEach(currentSuggestions) { item in
                        Text(item.displayText)
                            .font(.system(size: 18))
                            .onTapGesture {
                                text = item.value
                            }
                    }
                }
                .padding()
            }
            .background(Color.white)
            .border(Color.black, width: 1)
            .frame(height: 128)
        }
        .opacity(shouldDisplaySuggestions ? 1 : 0)
    }
    
    var currentSuggestions: [StationSuggestion] {
        suggestionFilter.currentSuggestions(for: text, suggestions: suggestions.wrappedValue)
    }
    
    var shouldDisplaySuggestions: Bool {
        !currentSuggestions.isEmpty && isBeingEdited
    }
    
    var isEnteredStationInvalid: Bool {
        !text.isEmpty &&
            !suggestionFilter.contains(text: text, in: suggestions.wrappedValue)
    }
}

struct StationStopTextField_Previews: PreviewProvider {
    @ObservedObject static var viewModelDefault = PrimaryViewModel()
    @ObservedObject static var viewModelPopulated: PrimaryViewModel = {
        let repo = StationsRepositoryImpl()
        var stations = [RailStation]()
        stations.append(RailStation(name: "Arklow", code: "1", id: 0))
        stations.append(RailStation(name: "Arklow1", code: "2", id: 1))
        stations.append(RailStation(name: "Arklow2", code: "3", id: 2))
        stations.append(RailStation(name: "London", code: "4", id: 4))
        stations.append(RailStation(name: "London1", code: "5", id: 5))
        stations.append(RailStation(name: "London2", code: "6", id: 6))
        repo.save(newData: stations)
        Resolver.register { repo as StationsRepository }
        
        let vm = PrimaryViewModel()
        vm.departureValue = "Lon"
        return vm
    }()
    
    static var previews: some View {
        Group {
            primaryViewDefault
            
            primaryViewSuggestions
        }
    }
    
    static var primaryViewDefault: StationStopTextField {
        let view = StationStopTextField(header: "From", titleKey: "Departure", text: $viewModelDefault.departureValue, suggestions: $viewModelDefault.stationSuggestions)
        return view
    }
    
    static var primaryViewSuggestions: StationStopTextField {
        let view = StationStopTextField(header: "From", titleKey: "Departure", text: $viewModelPopulated.departureValue, suggestions: $viewModelPopulated.stationSuggestions, isBeingEdited: true)
        return view
    }
}
