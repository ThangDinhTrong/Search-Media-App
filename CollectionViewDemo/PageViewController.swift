//
//  PageViewController.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/10/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    static var isLoadedFirstTime = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !PageViewController.isLoadedFirstTime {
            if let pageContentController = storyboard?.instantiateViewControllerWithIdentifier("PageContent") {
                setViewControllers([pageContentController], direction: .Forward, animated: true, completion: nil)
                PageViewController.isLoadedFirstTime = true
            }
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return storyboard?.instantiateViewControllerWithIdentifier("PageContent")
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return storyboard?.instantiateViewControllerWithIdentifier("PageContent")
    }

}
