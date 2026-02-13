import SwiftUI


struct NoteDetailView: View {
    
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(note.title)
                .font(.largeTitle)
                .strikethrough(note.isCompleted)
            
            Text(note.content)
                .padding()
                .strikethrough(note.isCompleted)
            
            Button(action: {
                viewModel.toggleCompletion(for: note)
            }) {
                Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(note.isCompleted ? Color.orange : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)  //customization 2
            }
            
            Spacer()
            
        }
        .padding()
        .navigationTitle("Details")
        .toolbar {
            NavigationLink(destination: AddEditNoteView(note: note, viewModel: viewModel)) {
                Text("Edit")
            }
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(
            note: Note(title: "Sample", content: "Sample content", isCompleted: false),
            viewModel: NotesViewModel()
        )
    }
}

