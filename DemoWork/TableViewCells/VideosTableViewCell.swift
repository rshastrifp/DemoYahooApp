//
//  VideosTableViewCell.swift
//  DemoWork
//
//  Created by Ronak Shahstri on 2021-03-01.
//

import UIKit

class VideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewThumb: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        self.imageViewThumb.image = UIImage(named: "Placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
