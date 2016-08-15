//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/1/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var indexCell:[Int] = [0,1,2,3,4]
    var mediaArray:[String] = ["musicVideo","movie","ebook","audiobook","podcast"]
    var currentCellIndexRow:Int = 0
    var lastCellIndexRow:Int = 0
    var audiobooks = [Audiobook]()
    var podcasts = [Podcast]()
    var musicvideos = [Musicvideo]()
    var movies = [Movie]()
    var ebooks = [Ebook]()
    var indexPaths = [NSIndexPath]()
    var pageViewController: UIPageViewController!
    var delegate:ViewControllerAssignDataDelegate!
    static var sharedViewController=ViewController()

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate=self
        
        for i in 0...4 {
            let index = NSIndexPath(forItem: i, inSection: 0)
            self.indexPaths.append(index)
        }
        
        if self.revealViewController() != nil {
            self.menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            if currentCellIndexRow != 0 {
                self.revealViewController().panGestureRecognizer().enabled = false
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pageView" {
            let destination = segue.destinationViewController as! PageViewController
            pageViewController = destination
            pageViewController.dataSource = self
        }
    }


}

extension ViewController:UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        switch indexPath.row {
        case 0:
            cell.label.text = "musicVideo"
        case 1:
            cell.label.text = "movie"
        case 2:
            cell.label.text = "ebook"
        case 3:
            cell.label.text = "audiobook"
        case 4:
            cell.label.text = "podcast"
        default:
            cell.label.text = ""
        }
        cell.backgroundColor = UIColor(red: 255, green: 175, blue: 50, alpha: 0)
        if indexPath.row==currentCellIndexRow {
            cell.backgroundColor = UIColor(red: 255, green: 90, blue: 50, alpha: 0.25)
        }
        return cell
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentCellIndexRow=indexPath.row
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        for index in self.indexPaths {
            self.collectionView.cellForItemAtIndexPath(index)?.backgroundColor = UIColor(red: 255, green: 175, blue: 50, alpha: 0)
        }
        self.collectionView.cellForItemAtIndexPath(indexPath)?.backgroundColor=UIColor(red: 255, green: 90, blue: 50, alpha: 0.25)
        self.searchBarSearchButtonClicked(self.searchBar)
        self.pageViewController.reloadInputViews()
    }
}

extension ViewController:SearchManagerDelegate {
    func assignData(ebooks: [Ebook]) {
        self.ebooks=ebooks
        ViewController.sharedViewController.delegate.assignData(currentCellIndexRow, musicvideos: musicvideos, movies: movies, ebooks: ebooks, audiobooks: audiobooks, podcasts: podcasts)

    }
    func assignData(movies: [Movie]) {
        self.movies=movies
        ViewController.sharedViewController.delegate.assignData(currentCellIndexRow, musicvideos: musicvideos, movies: movies, ebooks: ebooks, audiobooks: audiobooks, podcasts: podcasts)
    }
    func assignData(podcasts: [Podcast]) {
        self.podcasts=podcasts
        ViewController.sharedViewController.delegate.assignData(currentCellIndexRow, musicvideos: musicvideos, movies: movies, ebooks: ebooks, audiobooks: audiobooks, podcasts: podcasts)

    }
    func assignData(audiobooks: [Audiobook]) {
        self.audiobooks=audiobooks
        ViewController.sharedViewController.delegate.assignData(currentCellIndexRow, musicvideos: musicvideos, movies: movies, ebooks: ebooks, audiobooks: audiobooks, podcasts: podcasts)

    }
    func assignData(musicvideos: [Musicvideo]) {
        self.musicvideos=musicvideos
        ViewController.sharedViewController.delegate.assignData(currentCellIndexRow, musicvideos: musicvideos, movies: movies, ebooks: ebooks, audiobooks: audiobooks, podcasts: podcasts)


    }
}
extension ViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        SearchManager.shareSearchManager.delegate=self
        print("search \(mediaArray[currentCellIndexRow])")
        SearchManager.shareSearchManager.getDatafromSearchText(self.searchBar, media: mediaArray[currentCellIndexRow])
        self.pageViewController.reloadInputViews()
    }
}
extension ViewController:UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        print("swipe")
        self.revealViewController().panGestureRecognizer().enabled = false
        if currentCellIndexRow<4{
        self.currentCellIndexRow+=1
        }
        let index = NSIndexPath(forItem: currentCellIndexRow, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        for index in self.indexPaths {
            self.collectionView.cellForItemAtIndexPath(index)?.backgroundColor = UIColor(red: 255, green: 175, blue: 50, alpha: 0)
        }
        self.collectionView.cellForItemAtIndexPath(self.indexPaths[currentCellIndexRow])?.backgroundColor=UIColor(red: 255, green: 90, blue: 50, alpha: 0.25)
        SearchManager.shareSearchManager.delegate=self
        print("search \(mediaArray[currentCellIndexRow])")
        SearchManager.shareSearchManager.getDatafromSearchText(self.searchBar, media: mediaArray[currentCellIndexRow])
        return storyboard?.instantiateViewControllerWithIdentifier("PageContent")
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        print("swipe")
        print(currentCellIndexRow)
        if currentCellIndexRow>0 {
        self.currentCellIndexRow-=1
            if currentCellIndexRow==0 && self.revealViewController() != nil{
                self.revealViewController().panGestureRecognizer().enabled = true
                print(self.revealViewController().panGestureRecognizer().enabled)
            }
        }
        let index = NSIndexPath(forItem: currentCellIndexRow, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(index, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
        for index in self.indexPaths {
            self.collectionView.cellForItemAtIndexPath(index)?.backgroundColor = UIColor(red: 255, green: 175, blue: 50, alpha: 0)
        }
        self.collectionView.cellForItemAtIndexPath(self.indexPaths[currentCellIndexRow])?.backgroundColor=UIColor(red: 255, green: 90, blue: 50, alpha: 0.25)
        SearchManager.shareSearchManager.delegate=self
        print("search \(mediaArray[currentCellIndexRow])")
        SearchManager.shareSearchManager.getDatafromSearchText(self.searchBar, media: mediaArray[currentCellIndexRow])
        return storyboard?.instantiateViewControllerWithIdentifier("PageContent")
    }
}
protocol ViewControllerAssignDataDelegate {
    func assignData(currentCellIndexRow:Int,musicvideos:[Musicvideo],movies:[Movie],ebooks:[Ebook],audiobooks:[Audiobook],podcasts:[Podcast])
}