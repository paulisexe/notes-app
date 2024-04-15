import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project1/components/drawer.dart';
import 'package:project1/components/note_tile.dart';
import 'package:project1/models/note.dart';
import 'package:project1/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  // text controller to access what the user typed
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // on app startup, fetch exixting notes
    readNotes();
  }
  // create a note
  void createNote() {
    showDialog(context: context,
      builder: (context) =>
          AlertDialog(
            content: TextField(
            controller: textController,
          ),
      actions: [
        // create button
        MaterialButton(
          onPressed: () {
          context.read<NoteDatabase>().addNote(textController.text);

          // clear controller
          textController.clear();

          // pop the dialogue box
          Navigator.pop(context);
        },
        child: const Text("create"),
    )
  ],
          ),

    );

  }


  //read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note) {
    // pre-fill the current note text
    textController.text = note.text;
    showDialog(context: context,
      builder: (context) => AlertDialog(
        title: Text("update note"),
        content: TextField(controller: textController),
        actions: [
          // update button
          MaterialButton(onPressed: () {
            // update note in db
           context
        .read<NoteDatabase>()
        .updateNote(note.id, textController.text);
           //clear the controller
          textController.clear();
          //pop dialogue box
          Navigator.pop(context);
      },
       child: const Text("update"),
    )
    ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }
  @override
  Widget build(BuildContext context) {

    // note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Notes')),
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer: const MyDrawer() ,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADING
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text('Notes',style: GoogleFonts.dmSerifText(
              fontSize: 48,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ),
          ),


          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index){
                  // get induvidual note
                  final note = currentNotes[index];
            
                  // list title ui
                  return NoteTile(
                      text: note.text,
                    onEitPressed: () => updateNote(note),
                    onDeletePressed: () =>deleteNote(note.id),
                  );
            
                } ),
          ),
        ],
      )
    );
  }
}
