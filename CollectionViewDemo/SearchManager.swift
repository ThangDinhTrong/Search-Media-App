//
//  SearchManager.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/3/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import Foundation
import UIKit
class SearchManager {
    var session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask : NSURLSessionDataTask?
    var delegate:SearchManagerDelegate!
    static var shareSearchManager = SearchManager()
    var audiobooks = [Audiobook]()
    var podcasts = [Podcast]()
    var musicvideos = [Musicvideo]()
    var movies = [Movie]()
    var ebooks = [Ebook]()
    
    //use delegate
    func getDatafromSearchText(searchBar: UISearchBar,media:String) {
        if !searchBar.text!.isEmpty {
            if dataTask != nil {
                dataTask?.cancel()
            }
            let charSet = NSCharacterSet.URLQueryAllowedCharacterSet()
            let stringTerm = searchBar.text!.stringByAddingPercentEncodingWithAllowedCharacters(charSet)!
            let url = NSURL(string: "https://itunes.apple.com/search?media=\(media)&term=\(stringTerm)")
            dataTask = session.dataTaskWithURL(url!) {
                data,response,error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        self.updateData(data,media: media)
                    }
                }
            }
            dataTask?.resume()
        }
    }
    
    func updateData(data:NSData?,media:String) {
        switch media {
            case "movie":
                movies.removeAll()
                do {
                    if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
                        
                        // Get the results array
                        if let array: AnyObject = response["results"] {
                            for trackDictonary in array as! [AnyObject] {
                                if let trackDictonary = trackDictonary as? [String: AnyObject] {
                                    // Parse the search result
                                    let name = trackDictonary["trackName"] as? String
                                    let artist = trackDictonary["artistName"] as? String
                                    let imageUrl60 = trackDictonary["artworkUrl60"] as? String
                                    let imageUrl100 = trackDictonary["artworkUrl100"] as? String
                                    var trackPrice = trackDictonary["trackPrice"] as? Double
                                    if trackPrice == nil {
                                        trackPrice = 0
                                    }
                                    self.movies.append(Movie(artistName: artist!, trackName: name!, artworkUrl100: imageUrl100!, artworkUrl60:imageUrl60!, trackPrice: trackPrice!))
                                } else {
                                    print("Not a dictionary")
                                }
                            }
                        } else {
                            print("Results key not found in dictionary")
                        }
                    } else {
                        print("JSON Error")
                    }
                } catch let error as NSError {
                    print("Error parsing results: \(error.localizedDescription)")
                }
                self.delegate.assignData(movies)

            case "podcast":
                podcasts.removeAll()
                do {
                    if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
                        
                        // Get the results array
                        if let array: AnyObject = response["results"] {
                            for trackDictonary in array as! [AnyObject] {
                                if let trackDictonary = trackDictonary as? [String: AnyObject] {
                                    // Parse the search result
                                    let name = trackDictonary["trackName"] as? String
                                    let artist = trackDictonary["artistName"] as? String
                                    let imageUrl60 = trackDictonary["artworkUrl60"] as? String
                                    let imageUrl100 = trackDictonary["artworkUrl100"] as? String
                                    let collection = trackDictonary["collectionName"] as? String
                                    self.podcasts.append(Podcast(collectionName: collection!, artistName: artist!, trackName: name!, artworkUrl100: imageUrl100!,artworkUrl60: imageUrl60!))
                                } else {
                                    print("Not a dictionary")
                                }
                            }
                        } else {
                            print("Results key not found in dictionary")
                        }
                    } else {
                        print("JSON Error")
                    }
                } catch let error as NSError {
                    print("Error parsing results: \(error.localizedDescription)")
                }
                self.delegate.assignData(podcasts)
            case "musicVideo":
                musicvideos.removeAll()
                do {
                    if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
                        
                        // Get the results array
                        if let array: AnyObject = response["results"] {
                            for trackDictonary in array as! [AnyObject] {
                                if let trackDictonary = trackDictonary as? [String: AnyObject] {
                                    // Parse the search result
                                    let name = trackDictonary["trackName"] as? String
                                    let artist = trackDictonary["artistName"] as? String
                                    let imageUrl60 = trackDictonary["artworkUrl60"] as? String
                                    let imageUrl100 = trackDictonary["artworkUrl100"] as? String
                                    var trackPrice = trackDictonary["trackPrice"] as? Double
                                    if trackPrice == nil {
                                        trackPrice = 0
                                    }
                                    self.musicvideos.append(Musicvideo( trackName: name!,artistName: artist!, trackPrice: trackPrice!,artworkUrl100: imageUrl100!,artworkUrl60: imageUrl60!))
                                } else {
                                    print("Not a dictionary")
                                }
                            }
                        } else {
                            print("Results key not found in dictionary")
                        }
                    } else {
                        print("JSON Error")
                    }
                } catch let error as NSError {
                    print("Error parsing results: \(error.localizedDescription)")
                }
                self.delegate.assignData(musicvideos)
            case "ebook":
                ebooks.removeAll()
                do {
                    if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
                        
                        // Get the results array
                        if let array: AnyObject = response["results"] {
                            for trackDictonary in array as! [AnyObject] {
                                if let trackDictonary = trackDictonary as? [String: AnyObject] {
                                    // Parse the search result
                                    let name = trackDictonary["trackName"] as? String
                                    let artist = trackDictonary["artistName"] as? String
                                    let imageUrl60 = trackDictonary["artworkUrl60"] as? String
                                    let imageUrl100 = trackDictonary["artworkUrl100"] as? String
                                    var description = trackDictonary["description"] as? String
                                    if description == nil {
                                        description = ""
                                    }
                                    self.ebooks.append(Ebook(artistName: artist!, trackName: name!, artworkUrl100: imageUrl100!,artworkUrl60: imageUrl60!, description: description!))
                                } else {
                                    print("Not a dictionary")
                                }
                            }
                        } else {
                            print("Results key not found in dictionary")
                        }
                    } else {
                        print("JSON Error")
                    }
                } catch let error as NSError {
                    print("Error parsing results: \(error.localizedDescription)")
                }
                self.delegate.assignData(ebooks)
            
            case "audiobook":
                audiobooks.removeAll()
                do {
                    if let data = data, response = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue:0)) as? [String: AnyObject] {
                        
                        // Get the results array
                        if let array: AnyObject = response["results"] {
                            for trackDictonary in array as! [AnyObject] {
                                if let trackDictonary = trackDictonary as? [String: AnyObject] {
                                    // Parse the search result
                                    let name = trackDictonary["collectionName"] as? String
                                    let artist = trackDictonary["artistName"] as? String
                                    let imageUrl60 = trackDictonary["artworkUrl60"] as? String
                                    let imageUrl100 = trackDictonary["artworkUrl100"] as? String
                                    var description = trackDictonary["description"] as? String
                                    if description == nil {
                                        description = ""
                                    }
                                    self.audiobooks.append(Audiobook(collectionName: name!, artistName: artist!, artworkUrl100: imageUrl100!,artworkUrl60: imageUrl60!, description: description!))
                                } else {
                                    print("Not a dictionary")
                                }
                            }
                        } else {
                            print("Results key not found in dictionary")
                        }
                    } else {
                        print("JSON Error")
                    }
                } catch let error as NSError {
                    print("Error parsing results: \(error.localizedDescription)")
                }
                self.delegate.assignData(audiobooks)
            default:
                print(media)
                print("unknown type")
        }
    }
}

protocol SearchManagerDelegate {
    func assignData(movies:[Movie])
    func assignData(podcasts:[Podcast])
    func assignData(ebooks:[Ebook])
    func assignData(musicvideos:[Musicvideo])
    func assignData(audiobooks:[Audiobook])
}