//
//  IrishRailApp.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import SwiftUI

@main
struct IrishRailApp: App {
    let appComponents = AppComponents.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PrimaryView(viewModel: PrimaryViewModel())
            }
        }
    }
}
