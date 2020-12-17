//
//  popupAddNote.swift
//  test
//
//  Created by Элеста Элестов on 16.12.2020.
//  Copyright © 2020 Ruslan. All rights reserved.
//

import UIKit
import CoreData

class PopupAddNote: UIView {
    
    let container: UIView! = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let cancelButton: UIButton! = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        b.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        b.setTitle("Отмена", for: .normal)
        b.backgroundColor = .gray
        b.setTitleColor(.black, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return b
    }()
    
    let addButton: UIButton! = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        b.addTarget(self, action: #selector(addNoteAction), for: .touchUpInside)
        b.setTitle("Добавить заметку", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return b
    }()
    
    let noteTextField: UITextField! = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedPlaceholder = NSAttributedString(string: "Введите название заметки", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        label.textColor = .black
        return label
    }()
    
    @objc func cancelButtonAction(sender: UIButton!){
        self.removeFromSuperview()
    }
    
    @objc func addNoteAction(sender: UIButton!){
        guard let string = noteTextField?.text else {
            ViewController.waitingFlag = true
            self.removeFromSuperview()
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(string, forKey: "name")
        note.setValue("", forKey: "desc")
        note.setValue(NSDate(), forKey: "date")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        ViewController.arrayOfNotes.append(Note(name: string, time: NSDate(), description: ""))
        ViewController.waitingFlag = true
        self.removeFromSuperview()
        return
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            self.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        self.frame = frame
        self.addSubview(container)
        container.addSubview(cancelButton)
        container.addSubview(addButton)
        container.addSubview(noteTextField)
        container.backgroundColor = .white
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        container.layoutIfNeeded()
        cancelButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.4).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        cancelButton.layoutIfNeeded()
        addButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        addButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        addButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.6).isActive = true
        addButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        noteTextField.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        noteTextField.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        noteTextField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        noteTextField.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
