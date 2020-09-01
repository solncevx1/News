//
//  TableViewController.swift
//  TestProject
//
//  Created by Максим Солнцев on 6/12/20.
//  Copyright © 2020 Максим Солнцев. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    
    let dataSource = NewsDataSource()
    var filteredArticles: [Article] = []
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Wait to refresh...")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(myRefreshControl)
        searchBar.delegate = self 
        DispatchQueue.global().async { [weak self] in
            self?.dataSource.loadNews() {article in
                DispatchQueue.main.async {
                    self?.filteredArticles = article
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArticles.count
    }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let article = filteredArticles[indexPath.row]
        cell.dateLabel.text = article.publishedAt
        cell.descriptionLabel.text = article.title
        
        DispatchQueue.main.async {
            guard let url = URL(string: article.urlToImage ?? "") else {return}
            
                cell.imageNews.setImage(urlImage: url)
        }
        return cell
    }
   
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
       
       override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
  
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToOneNews", sender: self)
    }
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? OneNewsViewController)?.article = filteredArticles[tableView.indexPathForSelectedRow!.row]
        
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
   
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredArticles = dataSource.articles
            return
        }
        filteredArticles = dataSource.articles.filter({ article -> Bool in
            article.title?.lowercased().contains(searchText.lowercased()) ?? false})
        
        tableView.reloadData()
    }
    
    
    @objc func refreshNews() {
        dataSource.loadNews() {article in
            DispatchQueue.main.async {
                self.filteredArticles = article
                self.tableView.reloadData()
            }
        }
        myRefreshControl.endRefreshing()
    }
}
