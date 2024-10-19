import SwiftUI

struct EditDiaryEntryView: View {
    @Environment(\.dismiss) var dismiss // close form
    @Binding var diaryEntry: DiaryEntry // diary entry to edit

    @State private var date: Date
    @State private var emotion: String
    @State private var content: String

    let emotions = ["Happy", "Sad", "Angry", "Calm"]

    init(diaryEntry: Binding<DiaryEntry>) {
        _diaryEntry = diaryEntry
        _date = State(initialValue: diaryEntry.wrappedValue.date)
        _emotion = State(initialValue: diaryEntry.wrappedValue.emotion)
        _content = State(initialValue: diaryEntry.wrappedValue.content)
    }

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
            .navigationTitle("Edit Diary Entry")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        diaryEntry.date = date
                        diaryEntry.emotion = emotion
                        diaryEntry.content = content
                        dismiss()
                    }
                    .disabled(content.isEmpty)
                }
            }
        }
    }
}

struct EditDiaryEntryView_Previews: PreviewProvider {
    @State static var sampleEntry = DiaryEntry(date: Date(), emotion: "Happy", content: "Sample diary entry")

    static var previews: some View {
        EditDiaryEntryView(diaryEntry: $sampleEntry)
    }
}
