//
//  Day.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

struct Day: DayProtocol {
    var maxTempC: Float
    var maxTempF: Float
    var condition: ConditionProtocol
    
    private enum CodingKeys: String, CodingKey, CaseIterable {
        case maxtempC, maxtempF, condition
    }
    
    init(maxTempC: Float, maxTempF: Float, condition: ConditionProtocol) {
        self.maxTempC = maxTempC
        self.maxTempF = maxTempF
        self.condition = condition
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: CodingKeys.self)
        self.maxTempC = try data.decode(Float.self, forKey: .maxtempC)
        self.maxTempF = try data.decode(Float.self, forKey: .maxtempF)
        self.condition = try data.decode(Condition.self, forKey: .condition)
    }
}
