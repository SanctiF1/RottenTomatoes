//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by ToanVo on 11/10/15.
//  Copyright © 2015 ToanVo. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "https://coderschool-movies.herokuapp.com/movies?api_key=xja087zcvxljadsflh214")!
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            //(response: NSURLResponse!, data: NSData!, error:NSError!) -> Void in
           // let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary

          do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary

            if let json = json {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
            }
            //print(json)
          } catch let error as NSError {
               print(error)
          }
        }
        tableView.dataSource = self
        tableView.delegate = self // event
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }  else{
                return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        
        let movie = movies![indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        return cell
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
