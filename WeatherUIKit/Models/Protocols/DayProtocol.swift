//
//  DayProtocol.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

protocol DayProtocol: Decodable {
    var maxTempC: Float { get }
    var maxTempF: Float { get }
    var condition: ConditionProtocol { get }
}
