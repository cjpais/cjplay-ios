//
//  Note.swift
//  cjplay
//
//  Created by CJ Pais on 4/4/20.
//  Copyright © 2020 CJ Pais. All rights reserved.
//

import Foundation
import CoreData

public class Note: NSManagedObject, Identifiable {
    @NSManaged public var body: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var dateChanged: NSNumber?
}

extension Note {
    static func getAllNotes(ascending: Bool = false) -> NSFetchRequest<Note> {
        let request:NSFetchRequest<Note> = Note.fetchRequest() as! NSFetchRequest<Note>
        //request.fetchLimit = 5
        //request.fetchOffset = 0
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: ascending)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
