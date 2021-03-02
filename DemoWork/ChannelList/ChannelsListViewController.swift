//
//  ViewController.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import UIKit
import AVKit

class ChannelsListViewController: GenericViewController, ViewControllerProtocol {
    typealias ViewModelType = ChannelsListViewModel
    
    @IBOutlet weak var tableViewChannels: UITableView!
    var viewModel = ViewModelType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData() {
        viewModel.fetchChannels { (videos) in
            print(videos)
            DispatchQueue.main.async {
                self.tableViewChannels.reloadData()
            }
        } failure: { (error) in
            print(error)
        }

    }
    
    func getDetailsOFChannel(id: String) {
        //Spinner here.
        // Plus lock user interation with spinner.
        viewModel.fetchChannelDetails(channelId: id) { (channels) in
            if let channel = channels.first,
               let urlStr = channel.videoUrl,
               let url = URL(string: urlStr) {
                let player = AVPlayer(url: url)
                DispatchQueue.main.async {
                    let playerViewController = AVPlayerViewController()
                    playerViewController.player = player
                    self.present(playerViewController, animated: true) {
                        playerViewController.player!.play()
                    }
                }
            }
        } failure: { (error) in
            print(error)
        }
    }
}

extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.listVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thumbCell", for: indexPath) as? VideosTableViewCell {
            let videoViewModel = self.viewModel.listVideos[indexPath.row]
            cell.configureCell(videoViewModel: videoViewModel)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelId = viewModel.listVideos[indexPath.row].id
        getDetailsOFChannel(id: channelId)
    }
}

