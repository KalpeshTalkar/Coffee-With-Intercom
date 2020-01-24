//
//  FileReader.swift
//  Coffee With Intercom
//
//  Created by Kalpesh Talkar on 21/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

enum Environment {
    case Testing
    case Development
    case Production
}

let environment = Environment.Testing

struct Endpoints {

    // MARK: - Hosts
    
    static let DEVELOPMENT_DOMAIN = "https://s3.amazonaws.com/"
    static let PRODUCTION_DOMAIN = "https://s3.amazonaws.com/"

    static func getDomain() -> String {
        switch environment {
        case .Testing, .Development:
            return DEVELOPMENT_DOMAIN
        case .Production:
            return PRODUCTION_DOMAIN
        }
    }

    // MARK: - Endpoints
    
    static let customersFileName = "customers.txt"
    static let remoteCustomersFileUrl = getDomain() + "/intercom-take-home-test/" + customersFileName
    
}
