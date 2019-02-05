//
//  MoivesDetailViewController.swift
//  Flix
//
//  Created by Philip Irivng  on 2/3/19.
//  Copyright © 2019 Philip Irivng . All rights reserved.
//

import UIKit
import AlamofireImage

class MoivesDetailViewController: UIViewController {
    
    var movie: [String:Any]!
    
    @IBOutlet weak var backDropIMageView: UIImageView!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var descriptionView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleView.text = movie["title"] as? String
        descriptionView.text = movie["overview"] as? String
        
        descriptionView.sizeToFit()
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        posterView.af_setImage(withURL: posterURL!)
        
        let backDropPath = movie["backdrop_path"] as! String
        let backDropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backDropPath)
        backDropIMageView.af_setImage(withURL: backDropURL!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
