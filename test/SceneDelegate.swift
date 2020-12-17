//
//  SceneDelegate.swift
//  test
//
//  Created by Элеста Элестов on 16.12.2020.
//  Copyright © 2020 Ruslan. All rights reserved.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var notesManagedObject: [NSManagedObject] = []


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            notesManagedObject = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        for i in ViewController.arrayOfNotes{
            var checkInclude = false
            for j in notesManagedObject{
                let name = j.value(forKey: "name") as! String
                if(i.name == name){
                    checkInclude = true
                }
            }
            if(!checkInclude){
                let note = NSManagedObject(entity: entity, insertInto: managedContext)
                note.setValue(i.name, forKey: "name")
                note.setValue(i.description, forKey: "desc")
                note.setValue(i.time, forKey: "date")
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        do {
            notesManagedObject = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext)!
        for i in ViewController.arrayOfNotes{
            var checkInclude = false
            for j in notesManagedObject{
                let name = j.value(forKey: "name") as! String
                if(i.name == name){
                    checkInclude = true
                }
            }
            if(!checkInclude){
                let note = NSManagedObject(entity: entity, insertInto: managedContext)
                note.setValue(i.name, forKey: "name")
                note.setValue(i.description, forKey: "desc")
                note.setValue(i.time, forKey: "date")
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

