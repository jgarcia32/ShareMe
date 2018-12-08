//
//  NotesListViewController.swift
//  ShareMe
//
//  Created by Julian Garcia on 12/7/18.
//  Copyright © 2018 Julian Garcia. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

struct Notes {
    var title:String
    //var note:String
}

class NotesListViewController: UITableViewController {

    var db:Firestore!
    var notes: Notes?
    
    var notesArray = [Notes]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        loadData()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
        
        
    }
    
    func loadData() {
        //grab the collection from firestore db
        db.collection("userNotes").addSnapshotListener{ (querySnapshot, error) in
            if let error = error{
                print("\(error.localizedDescription)")
            }
            else
            {
                self.notesArray = []
                for document in (querySnapshot?.documents)!
                {
                    if let Title = document.data()["title"] as? String
                    {
                        //just a test to see if data is being pulled correctly
                        //print(Title)
                        
                        let note = Notes(title: Title)
                        //add every pulled note to the array
                        self.notesArray.append(note)
                        
                        
                    }
                    
                }
                DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                }
                
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = notesArray[indexPath.row]
        cell.textLabel?.text = note.title
        return cell
    }

}
