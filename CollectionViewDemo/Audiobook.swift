//
//  Audiobook.swift
//  CollectionViewDemo
//
//  Created by dinh trong thang on 8/3/16.
//  Copyright © 2016 dinh trong thang. All rights reserved.
//

import Foundation
class Audiobook {
    var collectionName:String = ""
    var artistName:String = ""
    var artworkUrl100:String = ""
    var artworkUrl60:String = ""
    var description:String = ""
    init(collectionName:String,artistName:String,artworkUrl100:String,artworkUrl60:String,description:String) {
        self.collectionName=collectionName
        self.artistName=artistName
        self.artworkUrl100=artworkUrl100
        self.description=description
        self.artworkUrl60=artworkUrl60
    }
}