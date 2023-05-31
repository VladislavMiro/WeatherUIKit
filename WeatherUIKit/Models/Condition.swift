//
//  Condition.swift
//  Weather
//
//  Created by Vladislav Miroshnichenko on 07.02.2023.
//

import Foundation

struct Condition: ConditionProtocol {
    var text: String = ""
    var icon: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case text, icon
    }
    
    init(text: String, icon: String) {
        self.text = text
        self.icon = icon
    }
    
    init(from decoder: Decoder) throws {
        let data =  try decoder.container(keyedBy: CodingKeys.self)
        
        text = try data.decode(String.self, forKey: .text)
        
        let imagePath = try data.decode(String.self, forKey: .icon)
        
        icon = imagePath.dropFirst(imagePath.count - 7).dropLast(4).description
    }
}
