//
//  DayView.swift
//  Playground
//
//  Created by LiYen Huang on 9/12/24.
//

import SwiftUI

struct DayView: View {
    var dayModel: DayModel?
    var diaryManager = DiaryManager() // TODO: Ensure a single instance
    
    var body: some View {
        let isToday = dayModel?.date.isToday() ?? false
        if let unwrappedDayModel = dayModel {
            let containDiary = diaryManager.getEntry( for: unwrappedDayModel.date ) != nil
            NavigationLink( destination: DailyView(date: unwrappedDayModel.date) ) {
                ZStack{
                    Rectangle()
                        .strokeBorder( isToday ? .red : .clear )
                        .cornerRadius(4)
                        .aspectRatio(contentMode: .fill)
                        .background(
                            Rectangle()
                                .fill( containDiary ? .indigo : .gray.opacity(0.4))
                                .cornerRadius(4)
                            )
                        
                        
                    
                    Text("\(Calendar.current.component(.day, from: dayModel?.date ?? Date()))")
                        .foregroundColor(.white)
                        .bold()
               }
            }
        }
        else {
            Rectangle()
                .foregroundColor( .clear )
                .aspectRatio(contentMode: .fill)
                .cornerRadius(3)
        }
    }
}

#Preview {
    DayView(dayModel: DayModel(date: Date.now))
}
