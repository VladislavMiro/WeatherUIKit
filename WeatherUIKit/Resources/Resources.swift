//
//  Resources.swift
//  WeatherUIKit
//
//  Created by Vladislav Miroshnichenko on 17.04.2023.
//

import UIKit

enum Resources {
    
    struct Colors {
        static let background = UIColor(named: "Background")
        static let secondBackground = UIColor(named: "SecondBackground")
    }
    
    struct StandartImages {
        static let wind = UIImage(systemName: "wind")
        static let humidity = UIImage(systemName: "drop.fill")
        static let cloud = UIImage(systemName: "cloud.fill")
    }
    
    struct Fonts {
        static let RussoOneRegular = "Russo One"
    }
    
    struct Symbols {
        static let precent = " %"
        static let celcius = " °"
        static let khSpeed = " K/H"
    }
    
    struct DateFormats {
        static let dayFullMonthNameFullDayName = "d MMMM, EEEE"
        static let oneNumberOfWeekDay = "E"
        static let twoNumbersOfHoursAndMinutes = "HH:mm"
    }
}
