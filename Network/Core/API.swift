//
//  API.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation
protocol ApiProtocol {
    var uri: String { get }
    var queryParams: [String: String] {get set}
    var pathParams: [String: String] {get set}
}

class API {
    static let baseUrl = "https://video.media.yql.yahoo.com/v1/"
    
    var pathParams: [String: String] = [String: String]()
    
    var uri: String {
        fatalError("API uri Has to be overridden.")
    }
    
    var queryParams: [String: String] = [String: String]()
    
    enum queryParamsStrings: String {
        case dev_type
        case video_uuid
        case site
        case region
        case lang
        case image_sizes
        case count
        case start
        case format
        case vpa
        case protocolString
        case rt
        case pver
    }
    
    enum PathParamsStrings: String {
        case videoId = "{_VIDEO_ID_}"
    }
}
