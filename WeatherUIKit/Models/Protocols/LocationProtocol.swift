//
//  LocationProtocol.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

protocol LocationProtocol: Decodable {
    var id: Int { get }
    var name: String { get }
    var lat: Float { get }
    var lon: Float { get }
    var localTime: Date { get set }
}
