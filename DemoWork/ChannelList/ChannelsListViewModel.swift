//
//  ChannelsListViewModel.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import Foundation

typealias SuccessViewModel = (_ vanues: [VideoViewModel]) -> Void

struct VideoViewModel {
    var id: String
    var thumImageUrl: String
    var videoUrl: String?
}

class ChannelsListViewModel {
    var listVideos = [VideoViewModel]()
    var currentQuesryValues = ChannelApiQuery(count: 30, startAt: 0)
    
    func fetchChannels(success: @escaping SuccessViewModel, failure: @escaping Failure) {
        ChannelsApi(channelApiQueries: currentQuesryValues).fetchData(){ [weak self] (channels) in
            guard let strongSelf = self else { return }
            for item in channels {
                strongSelf.listVideos.append(strongSelf.getVideoViewModelObject(item))
            }
            strongSelf.updateQueryCount()
            success(strongSelf.listVideos)
        } failure: { (error) in
            print(error)
            failure(error)
        }
    }
    
    func fetchChannelDetails(channelId: String, success: @escaping SuccessViewModel, failure: @escaping Failure) {
        ChannelDetailsApi(channleId: channelId).fetchData(){ [weak self] (channel) in
            guard let strongSelf = self else { return }
            if let index = strongSelf.findVideoIndexFor(id: channel.id) {
                strongSelf.listVideos[index].videoUrl = channel.videoUrl
                success([strongSelf.listVideos[index]])
            }
        } failure: { (error) in
            print(error)
            failure(error)
        }
    }
    
    func getVideoViewModelObject(_ channelResponseModel: ChannelResponseModel) -> VideoViewModel {
        return VideoViewModel(id: channelResponseModel.id,
                              thumImageUrl: channelResponseModel.thumbUrl,
                              videoUrl: nil)
    }
    
    func updateQueryCount() {
        currentQuesryValues.startAt += currentQuesryValues.count
    }
    
    func findVideoIndexFor(id: String) -> Int? {
        for (index,item) in listVideos.enumerated() {
            if (item.id == id) {
                return index
            }
        }
        return nil
    }
}
