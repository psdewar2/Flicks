//
//  MovieSelectionViewController.swift
//  Flicks
//
//  Created by Peyt Spencer Dewar on 1/7/16.
//  Copyright © 2016 PSD. All rights reserved.
//

import UIKit

class MovieSelectionViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var backdropView: UIImageView!
    @IBOutlet var movieInfoView: UIView!
    
    var movie: NSDictionary!
    
    //from tmdb url
    let baseUrl = "http://image.tmdb.org/t/p/w500"
    
    //var dataModel : DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let title = movie["title"] as? String
        titleLabel.text = title
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        if let posterPath = movie["poster_path"] as? String {
            
            let imageUrl = NSURL(string: baseUrl + posterPath)
            backdropView.setImageWithURL(imageUrl!)
            
        }
        
        let contentWidth = scrollView.frame.size.width
        let contentHeight = movieInfoView.frame.origin.y + movieInfoView.frame.size.height
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        /*
        self.title = dataModel!.movieTitle
        overviewLabel.text = dataModel!.movieSummary
        overviewLabel.sizeToFit()
        scrollOverview.addSubview(overviewLabel)
        scrollOverview.scrollsToTop = true
        backdropView.setImageWithURL(dataModel!.movieBackdrop!)
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}

class DataModel : NSObject {
    var movieTitle: String?
    var movieBackdrop: NSURL?
    var movieSummary: String?
    
    
    
}
