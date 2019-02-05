//
//  ViewController.swift
//  Flix
//
//  Created by Philip Irivng  on 1/23/19.
//  Copyright © 2019 Philip Irivng . All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource,
UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return Movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesCell") as! MoviesCell
        let movies = Movies[indexPath.row]
        let title = movies["title"] as! String
        let description = movies["overview"] as! String
        cell.titleLabel.text = title
        cell.descriptionLabel.text = description
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movies["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        cell.posterView.af_setImage(withURL: posterURL!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // find tge selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = Movies[indexPath.row]
        // Pass the selected moive to the details view controller
        let detailsViewController = segue.destination as! MoivesDetailViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    var Movies = [[String : Any]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.Movies = dataDictionary["results"] as! [[String:Any]]
                self.tableView.reloadData()
                
                print(dataDictionary)
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                //Keep Going It will work No mather WHAT
                
            }
        }
        task.resume()
    }
    
    
}

