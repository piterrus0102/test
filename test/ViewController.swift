//
//  ViewController.swift
//  test
//
//  Created by Элеста Элестов on 16.12.2020.
//  Copyright © 2020 Ruslan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var customTableView: UITableView!
    @IBOutlet weak var addNoteButton: UIButton!
    
    @IBOutlet weak var customTableViewHeight: NSLayoutConstraint!
    
    static var arrayOfNotes = [Note]()
    static var notesManagedObject: [NSManagedObject] = []
    
    var numberOfRows = 0
    var waitingTimer: Timer!
    
    static var waitingFlag = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTableView.estimatedRowHeight = 0
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        
        do {
            ViewController.notesManagedObject = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        for i in ViewController.notesManagedObject.indices {
            let name = ViewController.notesManagedObject[i].value(forKey: "name") as! String
            let description = ViewController.notesManagedObject[i].value(forKey: "desc") as! String
            let date = ViewController.notesManagedObject[i].value(forKey: "date") as! Date
            let note = Note(name: name, time: date as NSDate, description: description)
            ViewController.arrayOfNotes.append(note)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }
    
    @IBAction func addNoteAction(sender: UIButton){
        let pop = PopupAddNote(frame: UIScreen.main.bounds)
        self.view.addSubview(pop)
        waitingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ _ in
            if(ViewController.waitingFlag){
                ViewController.waitingFlag = false
                self.loadNotes()
                self.waitingTimer.invalidate()
            }
        }
    }
    
    func loadNotes(){
        ViewController.arrayOfNotes.sort { (note1, note2) -> Bool in
            let calendar = NSCalendar.current
            let components1 = calendar.component(Calendar.Component.nanosecond, from: note1.time as Date)
            let components2 = calendar.component(Calendar.Component.nanosecond, from: note2.time as Date)
            if(components1 < components2){
                return true
            }
            return false
        }
        numberOfRows = ViewController.arrayOfNotes.count
        customTableView.reloadData()
        customTableViewHeight.constant = customTableView.contentSize.height
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notecell", for: indexPath) as! CustomTableViewCell
        let dictItem = ViewController.arrayOfNotes[indexPath.row]
        let name = dictItem.name
        //let value = dictItem.value
        cell.selectionStyle = .none
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popupShowNote = PopupShowNote(frame: UIScreen.main.bounds)
        if(ViewController.arrayOfNotes[indexPath.row].description != ""){
            popupShowNote.noteTextField.text = ViewController.arrayOfNotes[indexPath.row].description
        }
        else{
            popupShowNote.noteTextField.attributedPlaceholder = NSAttributedString(string: "Введите описание заметки", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
        popupShowNote.note = ViewController.arrayOfNotes[indexPath.row]
        self.view.addSubview(popupShowNote)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .middle)
            ViewController.arrayOfNotes.remove(at: indexPath.row)
            numberOfRows = ViewController.arrayOfNotes.count
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            managedContext.delete(ViewController.notesManagedObject[indexPath.row])
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            tableView.endUpdates()
            customTableViewHeight.constant = customTableView.contentSize.height
        }
    }
    
}

