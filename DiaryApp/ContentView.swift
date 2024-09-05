import SwiftUI

struct ContentView: View {
    @State private var diaryEntries: [DiaryEntry] = []
    @State private var showEntryForm = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Content ScrollView
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(diaryEntries) { entry in
                            NavigationLink(destination: DiaryEntryDetailView(entry: entry)) {
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
                    }
                    .padding()
                }
                
                // Floating '+' Button to add a new entry
                VStack {
                    Spacer()
                    Button(action: {
                        showEntryForm.toggle()
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.bottom, 30)
                }
            }
            // Navigation Tool Bar
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("AI Diary")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Stats 화면")) {
                        Image(systemName: "chart.bar")
                    }
                    NavigationLink(destination: Text("Calendar 화면")) {
                        Image(systemName: "calendar")
                    }
                }
            }
        }
        .sheet(isPresented: $showEntryForm) {
            DiaryEntryForm(diaryEntries: $diaryEntries)
        }
        .padding(.top, 20)
        .padding(.horizontal, 12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
