//
//  EnvironmentConfig.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation

struct EnvironmentConfig {
    struct pathKey {
        static var channelList: String {return "channels"}
    }
    
    static var YahooApiList:[String: String] {
        return NSDictionary(contentsOfFile: ApiFilePath) as? [String:String] ?? [:]
    }
    
    private static var ApiFilePath: String {
        return Bundle.main.path(forResource: "Apis", ofType: "plist")!
    }
}
