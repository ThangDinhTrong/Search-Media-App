//
//  Musicvideo.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/3/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import Foundation
class Musicvideo {
    var trackName:String = ""
    var artistName:String = ""
    var trackPrice:Double = 0.0
    var artworkUrl100:String = ""
    var artworkUrl60:String = ""
    init(trackName:String,artistName:String,trackPrice:Double,artworkUrl100:String,artworkUrl60:String) {
        self.trackName=trackName
        self.artistName=artistName
        self.trackPrice=trackPrice
        self.artworkUrl100=artworkUrl100
        self.artworkUrl60=artworkUrl60
    }
}