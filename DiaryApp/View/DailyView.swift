//
//  DailyView.swift
//  DiaryApp
//
//  Created by LiYen Huang on 9/26/24.
//

import SwiftUI

struct DailyView: View {
    var date: Date
     
    var diaryManager = DiaryManager()
    
    var body: some View {
        
        if let diaryEntry = diaryManager.getEntry(for: date) {
            DiaryEntryRow( detailView: DiaryEntryDetailView(entry:  diaryEntry ) )
        }
        
    }
}

#Preview {
    DailyView(date: Date())
}
