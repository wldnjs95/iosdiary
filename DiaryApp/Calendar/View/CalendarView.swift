//
//  CalendarView.swift
//  Playground
//
//  Created by LiYen Huang on 9/13/24.
//

import SwiftUI

struct CalendarView: View {
    let calendarModel: CalendarModel
    @State var monthId: UUID?

    var body: some View {
        ScrollView{
            LazyVStack{
                ForEach(calendarModel.monthList) { monthModel in
                    MonthView(monthModel: monthModel)
                        .id(monthModel.id)
                        .padding(.vertical, 8)
                }
            }
        }
        .scrollPosition(id: $monthId, anchor: .top )
        .onAppear{ monthId = calendarModel.idForCurrentMonth() }
    }
}

#Preview {
    CalendarView(calendarModel: CalendarModel())
}
