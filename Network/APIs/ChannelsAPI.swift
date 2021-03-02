//
//  ChannelsAPI.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//
import Foundation
import SwiftyJSON

typealias SuccessResponseVideoList = (_ tsnResponseModel: [ChannelResponseModel]) -> Void

//dev_type=smartphone-app&video_uuid=eeaa1d1e-8840-39de-a488-ea444e7c832b&site=vsdk-demo-app&region=US&lang=en-US&image_sizes=640x360

struct ChannelApiQuery {
    var count: Int
    var startAt: Int
}

class ChannelsApi: API {
    override var uri: String {
        if let path = EnvironmentConfig.YahooApiList[EnvironmentConfig.pathKey.channelList] {
            return String(format: "%@%@", ChannelsApi.baseUrl, path)
        } else {
            fatalError("path needs to be defined in Apis.plist file.")
        }
    }
    
    init(channelApiQueries: ChannelApiQuery) {
        super.init()
        //We can pass this queries using a struct from the viewmodel as well.
        // Currently just using static values.
        let queries = [
            API.queryParamsStrings.dev_type.rawValue : "smartphone-app",
            API.queryParamsStrings.video_uuid.rawValue : "eeaa1d1e-8840-39de-a488-ea444e7c832b",
            API.queryParamsStrings.site.rawValue : "vsdk-demo-app",
            API.queryParamsStrings.region.rawValue : "US",
            API.queryParamsStrings.lang.rawValue : "en-US",
            API.queryParamsStrings.image_sizes.rawValue : "640x360",
            API.queryParamsStrings.count.rawValue: String(channelApiQueries.count),
            API.queryParamsStrings.start.rawValue: String(channelApiQueries.startAt)
        ]
        for (key, value) in queries {
            self.queryParams[key] = value
        }
    }
    
    func fetchData(success: @escaping SuccessResponseVideoList, failure: @escaping Failure) {
        ApiClient().execute(api: self, params: self.queryParams, success: { (data) in
            let jsonData = JSON(data)
            var listAllVideos = [ChannelResponseModel]()
            if let listVideosJson = jsonData["channel"]["result"][0]["videos"].array {
                for videoJson in listVideosJson {
                    listAllVideos.append(ChannelResponseModel(json: videoJson))
                }
            }
            success(listAllVideos)
        }) { (error) in
            print(error)
            failure(error)
        }
    }
}

