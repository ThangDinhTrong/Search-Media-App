//
//  Movie.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/3/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import Foundation
class Movie {
    var artistName:String = ""
    var trackName:String = ""
    var artworkUrl100:String = ""
    var trackPrice:Double = 0.0
    var artworkUrl60:String = ""
    init(artistName:String,trackName:String,artworkUrl100:String,artworkUrl60:String,trackPrice:Double) {
        self.artistName=artistName
        self.trackName=trackName
        self.artworkUrl100=artworkUrl100
        self.trackPrice=trackPrice
        self.artworkUrl60=artworkUrl60
    }
}