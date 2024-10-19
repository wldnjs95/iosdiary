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
        // NavigationView added
        NavigationView {
            ScrollViewReader { scrollViewProxy in
                CalendarView(calendarModel: calendarModel)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Calendar")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                withAnimation {
                                    scrollToToday(scrollViewProxy: scrollViewProxy)
                                }
                            }) {
                                Text("Today")
                            }
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
