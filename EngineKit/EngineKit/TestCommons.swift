

import Foundation
import XCTest


func setupRandomSeed() {
    let calendar = NSCalendar.currentCalendar()
    let units: NSCalendarUnit = .DayCalendarUnit |
        .MonthCalendarUnit |
        .YearCalendarUnit
    let components = calendar.components(units, fromDate: NSDate())

    let seed = components.day + components.month * 31 + components.year * 12*31

    srand(UInt32(seed))
}


func floatRand() -> Float {
    return Float(rand())
}


func randomFloat() -> Float {
    var f = (floatRand() / floatRand()) - (floatRand() / floatRand())
    f = f * f * f

    if (f == 0) {
        return randomFloat()
    }

    return f
}

