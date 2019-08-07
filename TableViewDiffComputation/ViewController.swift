//
//  ViewController.swift
//  TableViewDiffComputation
//
//  Created by Adhyam Nagarajan, Padmaja on 4/25/19.
//  Copyright © 2019 PayPal Inc. All rights reserved.
//

import UIKit

enum TileUpdateEvent {
  // section level update
  case insertedSections(IndexSet)
  case deletedSections(IndexSet)
  case staleSections(IndexSet) // Row level update event is used so far instead this event
  
  // row level update
  case insertedRows([IndexPath])
  case deletedRows([IndexPath])
  case staleRows([IndexPath])
}

class ViewController: UITableViewController, HomeTilesDelegate {
  
  var flag: Bool = true
  var data1 = ["apple", "banana", "cranberry", "kiwi"]
  var data2 = ["apple", "banana", "cranberry"]
  var data3 = ["kiwi", "mango", "apple", "banana", "avocado", "orange", "dates", "lemon"]
  
  private var viewModel: HomeTilesViewModel<String>?
  
  fileprivate lazy var refreshControlAnother: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
    refreshControl.tintColor = UIColor.black
    return refreshControl
  }()
  
  @objc private func handleRefresh() {
    if flag {
      viewModel?.update(data: data2)
    } else {
      viewModel?.update(data: data3)
    }
    flag = !flag
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: "AnotherTableViewCell", bundle: .main), forCellReuseIdentifier: "AnotherTableViewCell")
    tableView.refreshControl = refreshControlAnother

    viewModel = HomeTilesViewModel<String>(data: data1)
    viewModel?.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if flag {
      viewModel?.update(data: data2)
    } else {
      viewModel?.update(data: data3)
    }
    flag = !flag
  }
  
  override func viewDidAppear(_ animated: Bool) {
    print("view did appear")
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let vm = viewModel,
      let cell = tableView.dequeueReusableCell(withIdentifier: "AnotherTableViewCell", for: indexPath) as? AnotherTableViewCell else { return UITableViewCell() }
    cell.configure(name: vm[indexPath.section])
    return cell
  }
  
  func updateTiles(events es: [TileUpdateEvent]) {
    print(es)
    
    tableView.beginUpdates()
    es.forEach {
      switch $0 {
      case .insertedSections(let s):
        tableView.insertSections(s, with: .middle)
      case .deletedSections(let s):
        tableView.deleteSections(s, with: .middle)
      case .staleSections(let s):
        tableView.reloadSections(s, with: .middle)
      case .insertedRows(let paths):
        tableView.insertRows(at: paths, with: .middle)
      case .deletedRows(let paths):
        tableView.deleteRows(at: paths, with: .middle)
      case .staleRows(let paths):
        tableView.reloadRows(at: paths, with: .middle)
      }
    }
    tableView.endUpdates()
    tableView.refreshControl?.endRefreshing()
  }
}

class AnotherViewController: UIViewController {
  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.red
  }
}
