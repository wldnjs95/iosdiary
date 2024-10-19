//
//  DateExtensions.swift
//  Playground
//
//  Created by LiYen Huang on 9/12/24.
//

import Foundation

extension Date {
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let calendar = Calendar(identifier: .gregorian)
        var weekdaySymbols = calendar.shortWeekdaySymbols
        
        // Rotate array to start from Monday
        weekdaySymbols.append(weekdaySymbols.removeFirst())
        
        return weekdaySymbols.map { $0.prefix(1).uppercased() }
    }
    
    static var monthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        
        return (1...12).compactMap { month in
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let date = Calendar.current.date( from: DateComponents(year: 2000, month: month, day: 1) )
            return date.map{ dateFormatter.string(from: $0) }
            
        }
    }
    
    // get the date of the first day in the month of a date (Date)
    func firstDayOfMonth() -> Date {
        let calendar = Calendar.current

        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "YYYY"
        let year = Int(dateFormatter.string(from: self))
        
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    
    // get weekday of a date (Int)
    func weekDay() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday!
    }

    // add months from current date (Date)
    func plusMonth(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: count, to: self)!
    }
    
    // minus months from current date (Date)
    func minusMonth(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: -count, to: self)!
    }
    
    func isToday() -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let todayDateString = dateFormatter.string(from: Date())
        let dateToCompareString = dateFormatter.string(from: self)
        return (todayDateString == dateToCompareString)
    }
    
    var startOfMonth: Date {
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    
    var endOfMonth: Date {
        let lastDay = Calendar.current.dateInterval(of: .month, for: self)!.end
        return Calendar.current.date(byAdding: .day, value: -1, to: lastDay)!
    }
    
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var mondayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday + 5
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        
        // current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
        
        // previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
        return days.filter{ $0 >= mondayBeforeStart && $0 <= endOfMonth }.sorted(by: <)
        
    }
    
    var monthInt: Int {
        Calendar.current.component(.month, from: self)
    }
    
    // add days to current date (Date)
    func plusDate(_ count: Int = 1) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: count, to: self)!
    }
    
    static func createDateUsingComponents(year: Int, month: Int, day: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)
    }
}
