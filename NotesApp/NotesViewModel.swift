import SwiftUI
import Combine


class NotesViewModel: ObservableObject {
    
    @AppStorage("savedNotes") private var savedNotesData: Data = Data()
    
    @Published var notes: [Note] = [] {
        didSet {
            saveNotes()
        }
    }
    
    init() {
        loadNotes()
    }
    
    //add note
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content, isCompleted: false)
        notes.append(newNote)
    }
    
    //update note
    func updateNote(updatedNote: Note) {
        if let index = notes.firstIndex(where: { $0.id == updatedNote.id }) {
            notes[index] = updatedNote
        }
    }
    
    //toggle completion
    func toggleCompletion(for note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle()
        }
    }
    
    //delete note
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    //save notes
    private func saveNotes() {
        do {
            let encoded = try JSONEncoder().encode(notes)
            savedNotesData = encoded
        } catch {
            print("Error saving notes: \(error)")
        }
    }
    
    //load notes
    private func loadNotes() {
        guard !savedNotesData.isEmpty else { return }
        
        do {
            notes = try JSONDecoder().decode([Note].self, from: savedNotesData)
        } catch {
            print("Error loading notes: \(error)")
        }
    }
}



