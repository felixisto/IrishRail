//
//  NetworkSession.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import Foundation
import Combine

/*
 * This exists only to make testing less painful.
 */
protocol NetworkSession: AnyObject {
    func dataTaskPublisher(forURL url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
    func dataTaskPublisher(forRequest request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure>
}

class NetworkSessionStandard: NetworkSession {
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func dataTaskPublisher(forURL url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return session.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
    
    func dataTaskPublisher(forRequest request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, URLSession.DataTaskPublisher.Failure> {
        return session.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
