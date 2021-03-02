//
//  ChannelVideDetailsResponseModel.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation
import SwiftyJSON

struct ChannelVideDetailsResponseModel {
    let id: String
    let videoUrl: String
    init(json: JSON) {
        let host = json["query"]["results"]["mediaObj"][0]["streams"][0]["host"].string ?? ""
        let path = json["query"]["results"]["mediaObj"][0]["streams"][0]["path"].string ?? ""

        id = json["query"]["results"]["mediaObj"][0]["id"].string ?? ""
        videoUrl = String(format: "%@%@", host, path)
    }
}
