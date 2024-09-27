//
//  DayView.swift
//  Playground
//
//  Created by LiYen Huang on 9/12/24.
//

import SwiftUI

struct DayView: View {
    var dayModel: DayModel?
    
    var body: some View {
        let isToday = dayModel?.date.isToday() ?? false

        if let unwrappedDayModel = dayModel {
            NavigationLink( destination: DailyView(date: unwrappedDayModel.date) ) {
                ZStack{
                    Rectangle()
                        .foregroundColor( isToday ? .indigo : .gray.opacity(0.4))
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(3)
                    Text("\(Calendar.current.component(.day, from: dayModel?.date ?? Date()))")
                        .foregroundColor(.white)
                        .bold()
               }
            }
        }
    }
}

#Preview {
    DayView(dayModel: DayModel(date: Date.now))
}
