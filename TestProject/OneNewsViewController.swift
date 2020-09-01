//
//  OneNewsViewController.swift
//  TestProject
//
//  Created by Максим Солнцев on 6/12/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import UIKit
import SafariServices

class OneNewsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityImage: UIActivityIndicatorView!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var openSafariButton: UIButton!
 
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noImageLabel.isHidden = true
        descriptionLabel.text = article.description
        authorLabel.text = article.author
        
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage ?? "") {
                self.imageView.image = UIImage(data: try! Data(contentsOf: url))
            } else {
                self.activityImage.isHidden = true
                self.noImageLabel.isHidden = false
            }
        }
        
        if URL(string: article.url ?? "") == nil {
            openSafariButton.isHidden = true
        }
    }
    
    @IBAction func pushOpenNews(_ sender: UIButton) {
        if let url = URL(string: article.url ?? "") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
