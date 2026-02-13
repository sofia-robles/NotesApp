import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = NotesViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.3), .purple.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                List {
                    ForEach(viewModel.notes) { note in
                        NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(note.title)
                                        .font(.headline)
                                        .strikethrough(note.isCompleted)
                                    
                                    Text(note.content)
                                        .font(.subheadline)
                                        .lineLimit(1)
                                        .strikethrough(note.isCompleted)
                                }
                                
                                Spacer()
                                
                                if note.isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteNote)
                }
            }
            .navigationTitle("My Notes")
            .toolbar {
                NavigationLink(destination: AddEditNoteView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
