//
//  Post.swift
//  Sports App
//
//  Created by Joseph Sharp Halpin on 4/22/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

import Foundation
class Post {
    var location: String
    var time: String
    var sport: String
    var creator: String
    var latitude: String
    var longitude: String
    var description: String
    
    init(locationText: String, timeText: String, sportText: String, creatorText: String, latitudeText: String, longitudeText: String, descriptionText: String) {
        location = locationText
        time = timeText
        sport = sportText
        creator = creatorText
        latitude = latitudeText
        longitude = longitudeText
        description = descriptionText
    }
    
}
