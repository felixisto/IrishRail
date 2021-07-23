//
//  String+URLEncoding.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation

// MARK: URLEncoding
extension String {
    var encodedString: String {
        self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
