//
//  ViewController.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import UIKit

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
}

