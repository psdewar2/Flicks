//
//  MoviesCollectionViewController.swift
//  Flicks
//
//  Created by Peyt Spencer Dewar on 1/7/16.
//  Copyright © 2016 PSD. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var movies: [NSDictionary]?
    var endpoint: String!
    
    var filteredData: [NSDictionary]!
    
    //for refreshing
    var refreshControl: UIRefreshControl!
    
    //from tmdb url
    let baseUrl = "http://image.tmdb.org/t/p/w500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 150)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        filteredData = movies

        //searchBarPlaceholder.addSubview(searchController.searchBar)
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
        // Do any additional setup after loading the view.
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                            self.movies = responseDictionary["results"] as! [NSDictionary]
                            self.collectionView.reloadData()
                            
                    }
                }
        });
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //if movies is not nil then
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewMovieCell", forIndexPath: indexPath) as! NewMovieCell
        
        let movie: NSDictionary
        
        movie = movies![indexPath.item]
        
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        let title = movie["title"] as! String
        cell.titleLabel.text = title
        
        print("row \(indexPath.row)")
        
        if let posterPath = movie["poster_path"] as? String {
        
            let imageUrl = NSURL(string: baseUrl + posterPath)
            cell.posterView.setImageWithURL(imageUrl!)
            
        }
        
        return cell
        
    }

    /*
    var selectedData = DataModel()
    //for selecting item
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let movie = movies![indexPath.item]
        self.selectedData.movieTitle = movie["title"] as? String
        self.selectedData.movieSummary = movie["overview"] as? String
        
        
        
        
        //CHECK FOR NULL VALUES
        let posterPath = movie["poster_path"] as! String
        
        let imageUrl = NSURL(string: baseUrl + posterPath)
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = NSURL(string: baseUrl + backdropPath)
        print(backdropURL)
        self.selectedData.movieBackdrop = imageUrl
        print(self.selectedData.movieSummary)

    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let item = sender as! NewMovieCell
            let indexPath = collectionView.indexPathForCell(item)
            let movie = movies![indexPath!.item]
            let destinationVC = segue.destinationViewController as! MovieSelectionViewController
            destinationVC.movie = movie
            /*
            if let destinationVC = segue.destinationViewController as? MovieSelectionViewController {
                destinationVC.dataModel = self.selectedData
            }
*/
    }

    
    //used for refreshing
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
    //used for searching
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredData = movies!.filter { movie in
            return movie["title"]!.containsString(searchText)
        }
        collectionView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
}
