//
//  MonthView.swift
//  Playground
//
//  Created by LiYen Huang on 9/12/24.
//

import SwiftUI

struct MonthView: View {
    var monthModel: MonthModel
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    //@State private var days: [Date] = []

//    init(monthModel: MonthModel){
//        self.monthModel = MonthModel( date.startOfMonth )
//    }
    
    var firstDayOffset: Int {
        let num = (monthModel.firstDayOfMonth.weekDay() - 2) % 7
        return num < 0 ? num + 7 : num
    }
    
    var body: some View {
        VStack(alignment: .leading){
            // label of Month
            Text(monthName)
                .font(.title)
                .foregroundColor(.pink)
                .padding([.bottom], 10)
            
            // labels of weekdays
            HStack {
                ForEach(daysOfWeek, id: \.self){ day in
                    Text(day)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: columns){
                ForEach(0 ..< firstDayOffset) { _ in
                    DayView()
                }
                
                ForEach(monthModel.dayModelList, id: \.id) { dayModel in
                    DayView(dayModel: dayModel)
                }
            }
        }
        .padding([.leading, .trailing], 21)
    }

    private var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: monthModel.firstDayOfMonth)
    }
}

#Preview {
    MonthView(monthModel: MonthModel(Date()))
}
