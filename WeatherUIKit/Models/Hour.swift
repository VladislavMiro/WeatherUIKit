//
//  Hour.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 22.03.2023.
//

import Foundation

struct Hour: HourProtocol {
    var id: UUID = UUID()
    var time: Date
    var tempC: Float
    var tempF: Float
    var condition: ConditionProtocol
    var isDay: Bool
    var humidity: Int
    var cloud: Int
    var windKph: Float
    var windMph: Float
    
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case time, humidity, cloud, condition, tempC, tempF, isDay, windKph, windMph
    }
    
    init(time: Date, tempC: Float, tempF: Float, condition: ConditionProtocol, feelslikeC: Float,
         feelslikeF: Float, isDay: Bool, humidity: Int, cloud: Int, windKph: Float,
         windMph: Float) {
        self.time = time
        self.tempC = tempC
        self.tempF = tempF
        self.condition = condition
        self.humidity = humidity
        self.cloud = cloud
        self.windKph = windKph
        self.windMph = windMph
        self.isDay = isDay
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: CodingKeys.self)
        
        self.tempC = try data.decode(Float.self, forKey: .tempC)
        self.tempF = try data.decode(Float.self, forKey: .tempF)
        self.condition = try data.decode(Condition.self, forKey: .condition)
        self.humidity = try data.decode(Int.self, forKey: .humidity)
        self.cloud = try data.decode(Int.self, forKey: .cloud)
        self.windKph = try data.decode(Float.self, forKey: .windKph)
        self.windMph = try data.decode(Float.self, forKey: .windMph)
        
        let time = try data.decode(String.self, forKey: .time)
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        self.time = formatter.date(from: time) ?? Date()
    
        
        let isDayInt = try data.decode(Int.self, forKey: .isDay)
        
        if isDayInt == 1 {
            isDay = true
        } else {
            isDay = false
        }
    }
    
    
    
}
