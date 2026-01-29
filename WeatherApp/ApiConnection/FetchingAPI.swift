//
//  FetchingAPI.swift
//  WeatherApp
//
//  Created by rentamac on 1/29/26.
//

import Foundation
enum FetchingAPI{
    
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist is not found")
        }
        return dict
    }()
    
    static let baseURL : String = {
        guard let urlString = FetchingAPI.infoDict["baseURL"] as? String else{
            fatalError("baseURL is not found")
        }
        
//        guard let url = URL(string: urlString) else{
//            fatalError("baseURL is invalid")
//        }
        return urlString
    }()
    
    static let path : String = {
        guard let pathString = FetchingAPI.infoDict["path"] as? String else{
            fatalError("path is not found")
        }
        
//        guard let url = URL(string: pathString) else{
//            fatalError("path is invalid")
//        }
        return pathString
    }()
    
}
