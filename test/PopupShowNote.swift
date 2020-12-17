//
//  popupNoteShow.swift
//  test
//
//  Created by Элеста Элестов on 16.12.2020.
//  Copyright © 2020 Ruslan. All rights reserved.
//

import UIKit

class PopupShowNote: UIView {
    
    var note: Note!
    
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
        b.setTitle("Закрыть", for: .normal)
        b.backgroundColor = .gray
        b.setTitleColor(.black, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return b
    }()
    
    let editButton: UIButton! = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        b.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        b.setTitle("Редактировать", for: .normal)
        b.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        b.setTitleColor(.black, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return b
    }()
    
    let noteTextField: UITextField! = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .darkGray
        return textField
    }()
    
    @objc func cancelButtonAction(sender: UIButton!){
        if(sender.titleLabel?.text == "Закрыть"){
            self.removeFromSuperview()
            return
        }
        if(sender.titleLabel?.text == "Отмена"){
            editButton.setTitle("Редактировать", for: .normal)
            sender.setTitle("Закрыть", for: .normal)
            noteTextField.textColor = .darkGray
            noteTextField.isEnabled = false
            return
        }
    }
    
    @objc func editButtonAction(sender: UIButton){
        if(sender.titleLabel?.text == "Редактировать"){
            sender.setTitle("Сохранить", for: .normal)
            cancelButton.setTitle("Отмена", for: .normal)
            noteTextField.textColor = .black
            noteTextField.isEnabled = true
            return
        }
        if(sender.titleLabel?.text == "Сохранить"){
            sender.setTitle("Редактировать", for: .normal)
            cancelButton.setTitle("Закрыть", for: .normal)
            noteTextField.textColor = .darkGray
            noteTextField.isEnabled = false
            for i in ViewController.arrayOfNotes {
                if(i.name == note.name){
                    i.description = noteTextField.text
                }
            }
            return
        }
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
        container.addSubview(editButton)
        container.addSubview(noteTextField)
        noteTextField.isEnabled = false
        container.backgroundColor = .white
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        container.layoutIfNeeded()
        cancelButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        cancelButton.layoutIfNeeded()
        editButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true
        editButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.5).isActive = true
        editButton.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
        noteTextField.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        noteTextField.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        noteTextField.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8).isActive = true
        noteTextField.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
