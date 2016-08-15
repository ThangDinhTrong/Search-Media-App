//
//  MainTableViewController.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/10/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController,ViewControllerAssignDataDelegate {

    var currentCellIndexRow:Int = 0
    var audiobooks = [Audiobook]()
    var podcasts = [Podcast]()
    var musicvideos = [Musicvideo]()
    var movies = [Movie]()
    var ebooks = [Ebook]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load table")
        ViewController.sharedViewController.delegate=self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch currentCellIndexRow {
        case 0:
            return musicvideos.count
        case 1:
            return movies.count
        case 2:
            return ebooks.count
        case 3:
            return audiobooks.count
        case 4:
            return podcasts.count
        default:
            return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainTableViewCell
        switch currentCellIndexRow {
        case 0:
            cell.mainNameLabel.text = musicvideos[indexPath.row].trackName
            cell.mainArtistLabel.text = musicvideos[indexPath.row].artistName
            self.loadImageFromUrl(musicvideos[indexPath.row].artworkUrl60, view: cell.imageView!)
        case 1:
            cell.mainNameLabel.text = movies[indexPath.row].trackName
            cell.mainArtistLabel.text = movies[indexPath.row].artistName
            self.loadImageFromUrl(movies[indexPath.row].artworkUrl60, view: cell.imageView!)
        case 2:
            cell.mainNameLabel.text = ebooks[indexPath.row].trackName
            cell.mainArtistLabel.text = ebooks[indexPath.row].artistName
            self.loadImageFromUrl(ebooks[indexPath.row].artworkUrl60, view: cell.imageView!)
        case 3:
            cell.mainNameLabel.text = audiobooks[indexPath.row].collectionName
            cell.mainArtistLabel.text = audiobooks[indexPath.row].artistName
            self.loadImageFromUrl(audiobooks[indexPath.row].artworkUrl60, view: cell.imageView!)
        case 4:
            cell.mainNameLabel.text = podcasts[indexPath.row].trackName
            cell.mainArtistLabel.text = podcasts[indexPath.row].artistName
            self.loadImageFromUrl(podcasts[indexPath.row].artworkUrl60, view: cell.imageView!)
        default:
            cell.mainArtistLabel.text = ""
            cell.mainNameLabel.text = ""
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            if let indexPathTableView = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.currentCellIndexRow = currentCellIndexRow
                switch currentCellIndexRow {
                case 0:
                    destinationController.musicVideoObj = musicvideos[indexPathTableView.row]
                case 1:
                    destinationController.movieObj = movies[indexPathTableView.row]
                case 2:
                    destinationController.ebookObj = ebooks[indexPathTableView.row]
                case 3:
                    destinationController.audibookObj = audiobooks[indexPathTableView.row]
                case 4:
                    destinationController.podcastObj = podcasts[indexPathTableView.row]
                default:
                    print("Error")
                }
                
            }
        }
    }
    func loadImageFromUrl(url: String, view: UIImageView){
        
        let url = NSURL(string: url)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        }
        task.resume()
    }
    
    func assignData(currentCellIndexRow: Int, musicvideos: [Musicvideo], movies: [Movie], ebooks: [Ebook], audiobooks: [Audiobook], podcasts: [Podcast]) {
        self.currentCellIndexRow=currentCellIndexRow
        self.musicvideos=musicvideos
        self.movies=movies
        self.ebooks=ebooks
        self.audiobooks=audiobooks
        self.podcasts=podcasts
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
}

