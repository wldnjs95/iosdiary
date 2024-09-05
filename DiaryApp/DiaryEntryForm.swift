import SwiftUI

struct DiaryEntryForm: View {
    @Environment(\.dismiss) var dismiss // close form
    @Binding var diaryEntries: [DiaryEntry] // diary list from main

    @State private var date = Date()
    @State private var emotion = "Happy" // default value
    @State private var content = ""

    // 선택 가능한 감정 리스트
    let emotions = ["Happy", "Sad", "Angry", "Calm"]

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                Picker("Emotion", selection: $emotion) {
                    ForEach(emotions, id: \.self) { emotion in
                        Text(emotion)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                TextEditor(text: $content)
                    .frame(height: 200)
            }
            .navigationTitle("New Diary Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // 새로운 일기 항목 추가
                        let newEntry = DiaryEntry(date: date, emotion: emotion, content: content)
                        diaryEntries.append(newEntry)
                        dismiss()
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}

struct DiaryEntryForm_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntryForm(diaryEntries: .constant([]))
    }
}
