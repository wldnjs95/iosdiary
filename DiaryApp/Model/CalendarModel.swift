//
//  CalendarModel.swift
//  Playground
//
//  Created by LiYen Huang on 9/19/24.
//
import Foundation

class CalendarModel {
    @Published var monthList: [MonthModel]
    
    
    init(){
        let today = Date()
        let firstDayOfCurrentMonth = today.firstDayOfMonth()
        var firstDayOfMonth = firstDayOfCurrentMonth.minusMonth(5)
        
        self.monthList = [MonthModel(firstDayOfMonth)]
        
        for _ in 0..<11 {
            firstDayOfMonth = firstDayOfMonth.plusMonth()
            monthList.append(MonthModel(firstDayOfMonth))
        }
    }
    
    func idForCurrentMonth() ->  UUID {
        let today = Date()
        let firstDayOfCurrentMonth = today.firstDayOfMonth()

        let currentMonth = monthList.filter {$0.firstDayOfMonth == firstDayOfCurrentMonth}
        if (currentMonth.isEmpty) {
            return UUID()
        } else {
            return currentMonth[0].id
        }
    }
    
    func addMonthAfter(_ count: Int) async {
        sleep(5)
        
        var firstDayOfLastMonth = monthList.last?.firstDayOfMonth ?? Date().firstDayOfMonth()
        for _ in 0..<count {
            firstDayOfLastMonth = firstDayOfLastMonth.plusMonth()
            let monthModel = MonthModel(firstDayOfLastMonth)
            DispatchQueue.main.async {
                self.monthList.append( monthModel )
            }
        }
    }
    
    func addMonthBefore(_ count: Int) async {
        sleep(5)
        
        var firstDayOfLastMonth = monthList.last?.firstDayOfMonth ?? Date().firstDayOfMonth()
        for _ in 0..<count {
            firstDayOfLastMonth = firstDayOfLastMonth.plusMonth()
            let monthModel = MonthModel(firstDayOfLastMonth)
            DispatchQueue.main.async {
                self.monthList.append( monthModel )
            }
        }
    }
}
