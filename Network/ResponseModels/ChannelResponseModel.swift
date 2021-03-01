//
//  ChannelResponseModel.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation
import SwiftyJSON

struct ChannelResponseModel {
    var id: String
    var thumbUrl: String
    init(json: JSON) {
        id = json["id"].string ?? ""
        if let listImage = json["thumbnails"].array?.first {
            thumbUrl = listImage["url"].string ?? ""
        } else {
            thumbUrl = ""
        }
    }
}
