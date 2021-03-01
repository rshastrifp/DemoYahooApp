//
//  ViewController.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import UIKit

class ChannelsListViewController: UIViewController {
    
    @IBOutlet weak var tableViewChannels: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thumbCell", for: indexPath) as? VideosTableViewCell {
            cell.configureCell()
            return cell
        }
        return UITableViewCell()
    }
}

