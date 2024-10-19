import SwiftUI

struct DiaryEntryRow: View {
    @Binding var entry: DiaryEntry // diary to read

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.2))
            .frame(height: 120)
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(entry.date, style: .date)
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(entry.content)
                        .font(.body)
                        .foregroundColor(.black)
                        .lineLimit(2)
                }
                .padding()
            )
    }
}

#Preview{
    @Previewable @State var sampleEntry = DiaryEntry(date: Date(), emotion: "Happy", content: "Today was a great day!")
    DiaryEntryRow(entry: $sampleEntry)
}
