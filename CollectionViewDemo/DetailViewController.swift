//
//  DetailViewController.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/3/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var musicVideoObj:Musicvideo!
    var movieObj:Movie!
    var podcastObj:Podcast!
    var audibookObj:Audiobook!
    var ebookObj:Ebook!
    var currentCellIndexRow:Int!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch currentCellIndexRow {
        case 0:
            loadImageFromUrl(musicVideoObj.artworkUrl100, view: self.imageView)
        case 1:
            loadImageFromUrl(movieObj.artworkUrl100, view: self.imageView)
        case 2:
            loadImageFromUrl(ebookObj.artworkUrl100, view: self.imageView)
        case 3:
            loadImageFromUrl(audibookObj.artworkUrl100, view: self.imageView)
        case 4:
            loadImageFromUrl(podcastObj.artworkUrl100, view: self.imageView)
        default:
            print("Error image")
        }
        self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
        self.imageView.clipsToBounds = true

        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

}

extension DetailViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Collection"
            switch currentCellIndexRow {
            case 3:
                cell.detailLabel.text = audibookObj.collectionName
            case 4:
                cell.detailLabel.text = podcastObj.collectionName
            default:
                cell.detailLabel.text = "unknown"
            }
        case 1:
            cell.fieldLabel.text = "Track"
            switch currentCellIndexRow {
            case 0:
                cell.detailLabel.text = musicVideoObj.trackName
            case 1:
                cell.detailLabel.text = movieObj.trackName
            case 2:
                cell.detailLabel.text = ebookObj.trackName
            case 4:
                cell.detailLabel.text = podcastObj.trackName
            default:
                cell.detailLabel.text = "unknown"
            }
            
        case 2:
            cell.fieldLabel.text = "Artist"
            switch currentCellIndexRow {
            case 0:
                cell.detailLabel.text = musicVideoObj.artistName
            case 1:
                cell.detailLabel.text = movieObj.artistName
            case 2:
                cell.detailLabel.text = ebookObj.artistName
            case 3:
                cell.detailLabel.text = audibookObj.artistName
            case 4:
                cell.detailLabel.text = podcastObj.artistName
            default:
                cell.detailLabel.text = "unknown"
            }
        case 3:
            cell.fieldLabel.text = "Price"
            switch currentCellIndexRow {
            case 0:
                cell.detailLabel.text = String(musicVideoObj.trackPrice)
            case 1:
                cell.detailLabel.text = String(movieObj.trackPrice)
            default:
                cell.detailLabel.text = "unknown"
            }
        case 4:
            cell.fieldLabel.text = "Description"
            switch currentCellIndexRow {
            case 2:
                cell.detailLabel.text = ebookObj.description
            case 3:
                cell.detailLabel.text = audibookObj.description
            default:
                cell.detailLabel.text = "unknown"
            }
        default:
            cell.fieldLabel.text = "\n\n\n\n\n"
            cell.detailLabel.text = ""
        }
        return cell
    }
}
