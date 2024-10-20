import SwiftUI

struct ContentView: View {
    @State private var diaryEntries: [DiaryEntry] = []
    @State private var showEntryForm = false
    @State private var searchText = ""
    @State private var showSearchBar = false

    var filteredDiaryEntries: [DiaryEntry] {
        if searchText.isEmpty {
            return diaryEntries
        } else {
            return diaryEntries.filter { $0.content.contains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                // Background Content ScrollView
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredDiaryEntries.indices, id: \.self) { index in
                            NavigationLink(destination: DiaryEntryDetailView(entry: $diaryEntries[index])) {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 120)
                                    .overlay(
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(diaryEntries[index].date, style: .date)
                                                .font(.headline)
                                                .foregroundColor(.gray)
                                            Text(diaryEntries[index].content)
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
                    .onAppear {
                        showSearchBar = true
                    }
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
                    NavigationLink(destination: CalendarPage()) {
                        Image(systemName: "calendar")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search diary entries")
            .onChange(of: searchText) { newValue in
                showSearchBar = !newValue.isEmpty // 검색어가 있을 때만 검색바가 나타나도록 설정
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
