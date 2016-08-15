//
//  MenuTableViewController.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/4/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 64
        imageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Menu active")
        PageViewController.isLoadedFirstTime = false
        switch segue.identifier! {
            case "musicVideo":
                let viewController = segue.destinationViewController.childViewControllers[0] as! ViewController
                viewController.currentCellIndexRow = 0
            case "movie":
                let viewController = segue.destinationViewController.childViewControllers[0] as! ViewController
                viewController.currentCellIndexRow = 1
            case "ebook":
                let viewController = segue.destinationViewController.childViewControllers[0] as! ViewController
                viewController.currentCellIndexRow = 2
            case "audiobook":
                let viewController = segue.destinationViewController.childViewControllers[0] as! ViewController
                viewController.currentCellIndexRow = 3
            case "podcast":
                let viewController = segue.destinationViewController.childViewControllers[0] as! ViewController
                viewController.currentCellIndexRow = 4
        default:
            print("ko")
        }
    }

}
