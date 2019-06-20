//
//  HomeTilesViewModel.swift
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 4/25/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

import Foundation

protocol HomeTilesDelegate: NSObject {
  func updateTiles(events es: [TileUpdateEvent])
}

class HomeTilesViewModel<T: Equatable> {
  
  private var data: [T]
  weak var delegate: HomeTilesDelegate?
  
  init(data:[T]) {
    self.data = data
  }
  
  func update(data: [T]) {
    
    let diff = LCS.solve(self.data, data)
    var es: [TileUpdateEvent] = []
    
    if !diff.deleted.isEmpty && diff.deleted == diff.inserted {
      // Animation optimization. Reload to avoid nasty delete and insert animation.
      // ❌ [delete row 1, insert row 1]
      // ✅ [reload row 1]
      for deletedIndex in diff.deleted {
        es.append(.staleSections(IndexSet(integer: deletedIndex)))
      }
    } else {
      if !diff.deleted.isEmpty {
        for deletedIndex in diff.deleted {
          es.append(.deletedSections(IndexSet(integer: deletedIndex)))
        }
      }
      if !diff.inserted.isEmpty {
        for insertedIndex in diff.inserted {
          es.append(.insertedSections(IndexSet(integer: insertedIndex)))
        }
      }
    }
      
    self.data = data
    delegate?.updateTiles(events: es)
  }
  
  subscript(index: Int) -> T {
    return data[index]
  }
  
  var count: Int {
    return data.count
  }
}
