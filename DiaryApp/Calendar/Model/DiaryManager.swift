//
//  DiaryManager.swift
//  DiaryApp
//
//  Created by LiYen Huang on 10/3/24.
//
import Foundation

@Observable
class DiaryManager {
    var diaryEntries: [DiaryEntry]
    
    init() {
        #if DEBUG
        // sample data for preview
        self.diaryEntries = [
            DiaryEntry(date: Date(), emotion: "Happy", content: "Today was a great day!"),
            DiaryEntry(date: Date().addingTimeInterval(-86400), emotion: "Sad", content: "Yesterday was a tough day.")
        ]
        #else
        // app ebuild
        self.diaryEntries = load("DiaryContent.json")
        #endif
    }
    
    // 특정 날짜에 해당하는 일기 가져오기
    func getEntry(for date: Date) -> DiaryEntry? {
        let calendar = Calendar.current
        return diaryEntries.first { entry in
            calendar.isDate(entry.date, inSameDayAs: date)
        }
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
