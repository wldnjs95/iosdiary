//
//  CalendarPage.swift
//  Playground
//
//  Created by LiYen Huang on 9/26/24.
//

import SwiftUI

struct CalendarPage: View {
    var calendarModel = CalendarModel()

    var body: some View {
        ScrollViewReader { proxy in
            CalendarView( calendarModel: calendarModel )
                .navigationTitle("Calendar")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button( "Today" ) {
                            scrollToToday(scrollViewProxy: proxy)
                        }
                    }
                }
        }
    }
    
    // go to today's date
    func scrollToToday(scrollViewProxy: ScrollViewProxy) {
        let todayMonthId = calendarModel.idForCurrentMonth()
        scrollViewProxy.scrollTo(todayMonthId, anchor: .top) // Scroll to the current month
    }
}

#Preview {
    CalendarPage()
}
