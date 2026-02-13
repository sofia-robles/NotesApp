import SwiftUI


struct NoteDetailView: View {
    
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(note.title)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .kerning(1.2)
                .foregroundColor(note.isCompleted ? .gray : .primary)
                .strikethrough(note.isCompleted)

            Text(note.content)
                .font(.system(size: 18))
                .foregroundColor(.secondary)
                .lineSpacing(6)
                .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                viewModel.toggleCompletion(for: note)
            }) {
                Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(note.isCompleted ? Color.orange : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)              }
            
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Details")
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.blue.opacity(0.15),
                    Color.purple.opacity(0.15)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
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

