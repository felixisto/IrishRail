//
//  NavigationLazyView.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 23.07.21.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
