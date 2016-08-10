//
//  Ebook.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/3/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import Foundation
class Ebook {
    var artistName:String = ""
    var trackName:String = ""
    var artworkUrl100:String = ""
    var artworkUrl60:String = ""
    var description:String = ""
    init(artistName:String,trackName:String,artworkUrl100:String,artworkUrl60:String,description:String) {
        self.artistName=artistName
        self.trackName=trackName
        self.artworkUrl100=artworkUrl100
        self.description=description
        self.artworkUrl60=artworkUrl60
    }
}