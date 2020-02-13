//
//  Quake.swift
//  Quakes
//
//  Created by brian vilchez on 2/13/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation
import MapKit

class Quake: NSObject, Decodable {
     //place
    // time
    //magnitude
    //coordinates
    let magnitude: Double
    let place: String
    let time: Date
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case properties
        case time
        case place
        case geometry
        case coordinates
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        self.magnitude = try properties.decode(Double.self, forKey: .magnitude)
        self.place = try properties.decode(String.self, forKey: .place)
        self.time = try properties.decode(Date.self, forKey: .time)
        
        let geometry = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
        var coordinates = try geometry.nestedUnkeyedContainer(forKey: .coordinates)
        self.longitude = try coordinates.decode(Double.self)
        self.latitude = try coordinates.decode(Double.self)
       
        super.init()
    }
}
