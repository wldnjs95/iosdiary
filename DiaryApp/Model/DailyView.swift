//
//  DailyView.swift
//  DiaryApp
//
//  Created by LiYen Huang on 9/26/24.
//

import SwiftUI

struct DailyView: View {
    var date: Date
        
    var body: some View {
        Text("\(date)")
    }
}

#Preview {
    DailyView(date: Date())
}
