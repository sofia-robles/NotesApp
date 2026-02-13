import SwiftUI

struct AddEditNoteView: View {
    
    var note: Note?
    @ObservedObject var viewModel: NotesViewModel
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Enter title", text: $title)
            }
            
            Section(header: Text("Content")) {
                TextEditor(text: $content)
                    .frame(height: 200)
            }
        }
        .navigationTitle(note == nil ? "Add Note" : "Edit Note")
        .toolbar {
            Button("Save") {
                if let existingNote = note {
                    let updatedNote = Note(
                        id: existingNote.id,
                        title: title,
                        content: content,
                        isCompleted: existingNote.isCompleted
                    )
                    viewModel.updateNote(updatedNote: updatedNote)
                } else {
                    viewModel.addNote(title: title, content: content)
                }
                dismiss()
            }
        }
        .onAppear {
            if let note = note {
                title = note.title
                content = note.content
            }
        }
    }
}

struct AddEditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditNoteView(viewModel: NotesViewModel())
    }
}
