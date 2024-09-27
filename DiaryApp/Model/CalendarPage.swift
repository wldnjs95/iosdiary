//
//  CalendarPage.swift
//  Playground
//
//  Created by LiYen Huang on 9/26/24.
//

import SwiftUI

struct CalendarPage: View {
    var calendarModel = CalendarModel()
    var calendarView: CalendarView
    
    init() {
        calendarView = CalendarView(calendarModel: calendarModel )
    }
    
    var body: some View {
        calendarView
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CalendarPage()
}
