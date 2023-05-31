//
//  Forecast.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

struct Forecast: ForecastProtocol {
    var id: UUID = UUID()
    var date: Date
    var day: DayProtocol
    var hour: [HourProtocol]
    
    private enum CodingKeys: String, CodingKey {
       case date, day, hour
    }
    
    init(date: Date, day: DayProtocol, hour: [HourProtocol]) {
        self.date = date
        self.day = day
        self.hour = hour
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: CodingKeys.self)
        
        let date = try data.decode(String.self, forKey: .date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.date = formatter.date(from: date) ?? Date()
        print(self.date)
        self.day = try data.decode(Day.self, forKey: .day)
        self.hour = try data.decode([Hour].self, forKey: .hour)
    }
    
}
