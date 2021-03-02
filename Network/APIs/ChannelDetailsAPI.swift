//
//  ChannelDetailsApi.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation
import SwiftyJSON

//https://video.media.yql.yahoo.com/v1/video/sapi/streams/{_VIDEO_ID_}?format=fmp4,m3u8&devtype=smartphone-app&vpa=1&protocol=http&region=US&lang=en-US&site=vsdk-demo-app&rt=html&pver=5.7.2
//

typealias SuccessResponseVideoDetails = (_ tsnResponseModel: ChannelVideDetailsResponseModel) -> Void

class ChannelDetailsApi: API {
    override var uri: String {
        if var path = EnvironmentConfig.YahooApiList[EnvironmentConfig.pathKey.channelDetails] {
            path = path.replacingOccurrences(of: API.PathParamsStrings.videoId.rawValue,
                                             with: self.channleId)
            return String(format: "%@%@", ChannelsApi.baseUrl, path)
        } else {
            fatalError("path needs to be defined in Apis.plist file.")
        }
    }
    
    var channleId = ""
    
    init(channleId: String) {
        super.init()
        //We can pass this queries using a struct from the viewmodel as well.
        // Currently just using static values.
        let queries = [
            API.queryParamsStrings.format.rawValue: "fmp4,m3u8",
            API.queryParamsStrings.dev_type.rawValue : "smartphone-app",
            API.queryParamsStrings.vpa.rawValue: "1",
            API.queryParamsStrings.protocolString.rawValue: "http",
            API.queryParamsStrings.region.rawValue : "US",
            API.queryParamsStrings.lang.rawValue : "en-US",
            API.queryParamsStrings.site.rawValue : "vsdk-demo-app",
            API.queryParamsStrings.rt.rawValue : "html",
            API.queryParamsStrings.pver.rawValue : "5.7.2"
        ]
        for (key, value) in queries {
            self.queryParams[key] = value
        }
        
        self.channleId = channleId
    }
    
    func fetchData(success: @escaping SuccessResponseVideoDetails, failure: @escaping Failure) {
        ApiClient().execute(api: self, params: self.queryParams, success: { (data) in
            let jsonData = JSON(data)
            let response = ChannelVideDetailsResponseModel(json: jsonData)
            success(response)
        }) { (error) in
            print(error)
            failure(error)
        }
    }
}


