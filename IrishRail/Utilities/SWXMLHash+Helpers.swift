//
//  SWXMLHash+Helpers.swift
//  IrishRail
//
//  Created by Kristiyan Butev on 22.07.21.
//

import SWXMLHash

extension SWXMLHash {
    public static var shared: SWXMLHash = {
        let instance = SWXMLHash.config { options in
            options.caseInsensitive = true
        }
        return instance
    }()
}

extension XMLIndexer {
    var valueAsString: String? {
        let v: String? = try? value()
        return v
    }
    
    var valueAsInt: Int? {
        let v: Int? = try? value()
        return v
    }
    
    var valueAsDouble: Double? {
        let v: Double? = try? value()
        return v
    }
}

