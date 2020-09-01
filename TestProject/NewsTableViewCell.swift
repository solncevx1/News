//
//  NewsTableViewCell.swift
//  TestProject
//
//  Created by Максим Солнцев on 6/15/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        imageNews.layer.cornerRadius = imageNews.frame.size.width/2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
