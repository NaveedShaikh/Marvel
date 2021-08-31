//
//  MARVELconfig.swift
//  Marvel
//
//  Created by Naveed Shaikh on 31/08/21.
//

import Foundation


public enum PlistKey {
    case ServerURL
    case TimeoutInterval
    
    func value() -> String {
        switch self {
        case .ServerURL:
            return "server_url"
        case .TimeoutInterval:
            return "timestamp"
        
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURL:
            return infoDict[PlistKey.ServerURL.value()] as! String
        case .TimeoutInterval:
            return infoDict[PlistKey.TimeoutInterval.value()] as! String
        
        }
    }
}
