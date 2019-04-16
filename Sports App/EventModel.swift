//
//  EventModel.swift
//  Sports App
//
//  Created by Frank Frisbee on 4/8/19.
//  Copyright © 2019 CS 472. All rights reserved.
//

class EventModel {
    
    var address: String?
    var creator: String?
    var datetime: String?
    var description: String?
    var latitude: String?
    var longitude: String?
    var sports: String?
    
    //initialize all variables
    init(address: String?, creator: String?, datetime: String?, description: String?,
         latitude: String?, longitude: String?, sports: String?) {
        
        self.address = address
        self.creator = creator
        self.datetime = datetime
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.sports = sports
        
    }
    
    
}
