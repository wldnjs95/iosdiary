//
//  Month.swift
//  Playground
//
//  Created by LiYen Huang on 9/13/24.
//

import Foundation

class MonthModel: Identifiable {
    var id = UUID()
    
    var firstDayOfMonth: Date
    var startingSpaces: Int
    var dayModelList: Array<DayModel>
    
    init(_ firstDayOfMonth: Date) {
        self.firstDayOfMonth = firstDayOfMonth
        self.startingSpaces = firstDayOfMonth.weekDay()

        dayModelList = Array()
        var currentDay = firstDayOfMonth
        for _ in 1...firstDayOfMonth.numberOfDaysInMonth {
            dayModelList.append(DayModel(date: currentDay))
            currentDay = currentDay.plusDate()
        }
    }
}
