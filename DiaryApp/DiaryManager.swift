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
    
    // Singleton instance
    static let shared = DiaryManager()
    
    // Private initializer to ensure singleton pattern
    private init() {
        self.diaryEntries = []
        loadEntries()
    }
    
    // Private method to load entries
    private func loadEntries() {
        
        do {
            self.diaryEntries = try load("DiaryContent.json")
        } catch {
            print("Error loading diary entries: \(error)")
            self.diaryEntries = []
        }
    }

    // Retrieve all diary entries for a specific date
    func getEntries(for date: Date) -> [DiaryEntry] {
        let calendar = Calendar.current
        return diaryEntries.filter { entry in
            calendar.isDate(entry.date, inSameDayAs: date)
        }
    }
                                        
    // Add new entry
    func addEntry(_ entry: DiaryEntry) {
        diaryEntries.append(entry)
        saveEntries()
    }
    
    // Update existing entry
    func updateEntry(_ entry: DiaryEntry, at index: Int) {
        guard index < diaryEntries.count else { return }
        diaryEntries[index] = entry
        saveEntries()
    }
    
    // Delete entry
    func deleteEntry(at index: Int) {
        guard index < diaryEntries.count else { return }
        diaryEntries.remove(at: index)
        saveEntries()
    }
    
    // Save entries to file
    private func saveEntries() {
        // Implementation for saving entries to file
        // Add this when you need persistence
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
