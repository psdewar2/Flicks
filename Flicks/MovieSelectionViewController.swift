//
//  MovieSelectionViewController.swift
//  Flicks
//
//  Created by Peyt Spencer Dewar on 1/7/16.
//  Copyright © 2016 PSD. All rights reserved.
//

import UIKit

class MovieSelectionViewController: UIViewController {

    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var backdropView: UIImageView!
    
    var dataModel : DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        overviewLabel.text = dataModel!.movieSummary
        backdropView.image = dataModel!.movieBackdrop
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
    var movieSummary: String?
    var movieBackdrop: UIImage?
}
