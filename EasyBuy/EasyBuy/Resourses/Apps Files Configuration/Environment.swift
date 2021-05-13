//
//  Environment.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21.
//

import Foundation

public enum Environment {
    private static let pathDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let getBaseURL: URL = {
        guard let baseString = Environment.pathDictionary["baseURL"] as? String else {
            fatalError("baseURL not set in plist for this environment")
        }

        guard let baseUrl = URL(string: baseString) else {
            fatalError("baseURL is not a valid URL, verified in xccconfig")
        }

        return baseUrl
    }()

}
