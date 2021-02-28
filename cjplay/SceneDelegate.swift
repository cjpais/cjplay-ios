//
//  SceneDelegate.swift
//  cjplay
//
//  Created by CJ Pais on 3/28/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private func notesHack(context: NSManagedObjectContext, state: CJState) {
        /* Hack code to insert dates correctly into DB lol */
        do {
            let notes = try context.fetch(Note.getAllNotes())
            for (i, note) in notes.enumerated() {
                note.dateChanged = false
                if i != 0 {
                    if !datesAreSameDay(date1: notes[i-1].createdAt, date2: note.createdAt) {
                        notes[i-1].dateChanged = true
//                        print(notes[i-1])
//                        print(note)
                    }
                }
                
                /* Set all notes as synced */
//                note.synced = true
                
                /* Remove empty notes */
                if note.body != nil && note.body! == "" {
                    context.delete(note)
                } else if note.synced != nil && note.synced as! Bool == false {
                    print("attempting to sync note")
                    state.sendThought(note: note, context: context)
                }
                
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        } catch  {
            print("cant get notes")
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        // Create the SwiftUI view that provides the window contents.
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            fatalError("Unable to read managed object context.")
        }
        let contentView = ConversationView().environment(\.managedObjectContext, context)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                
                notesHack(context: context, state: appDelegate.cjState)
                
                window.rootViewController = UIHostingController(rootView: contentView.environmentObject(appDelegate.cjState))
                self.window = window
                window.makeKeyAndVisible()
            } else {
                print("GET FUCKED")
            }
        }
        

        
    }
    
    func datesAreSameDay(date1: Date?, date2: Date?) -> Bool {
        var ret: Bool = true
        
        if date1 != nil && date2 != nil {

            var cal = Calendar(identifier: .gregorian)
            cal.locale = Locale.current

            let date1Components = cal.dateComponents([.day, .month, .year], from: date1!)
            let date2Components = cal.dateComponents([.day, .month, .year], from: date2!)
            
            if date1Components != date2Components {
                ret = false
            }
        }
        
        return ret
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("disconnect", Date())
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("active", Date())
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("not active", Date())
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("resumed", Date())
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("entered background @", Date())
    }

}

