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
    
    func configureCell(videoViewModel: VideoViewModel) {
        setTumbImage(urlString: videoViewModel.thumImageUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setTumbImage(urlString: String) {
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imageViewThumb?.image = image
                        }
                    }
                }
            }
        }
        self.imageViewThumb?.image = UIImage(named: "Placeholder")
    }
    
    override func prepareForReuse() {
        self.imageViewThumb?.image = UIImage()
    }
}
