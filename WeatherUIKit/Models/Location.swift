//
//  Location.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

struct Location: LocationProtocol {
    var id: Int = 0
    var name: String
    var lat: Float
    var lon: Float
    var localTime: Date
    
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case id, name, lat, lon, localtime
    }
    
    init(id: Int = 0, name: String, latitude: Float, longitude: Float) {
        self.id = id
        self.name = name
        self.lat = latitude
        self.lon = longitude
        self.localTime = Date()
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? data.decode(Int.self, forKey: .id) {
            self.id = id
        } else {
            self.id = 0
        }
        
        self.name = try data.decode(String.self, forKey: .name)
        self.lat = try data.decode(Float.self, forKey: .lat)
        self.lon = try data.decode(Float.self, forKey: .lon)
        
        let date = try data.decode(String.self, forKey: .localtime)
        let formatter = DateFormatter()
        self.localTime = formatter.date(from: date) ?? Date()
    }
}
