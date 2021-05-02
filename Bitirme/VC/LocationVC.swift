//
//  LocationVC.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 24.04.2021.
//

import UIKit

struct Section{
    let title: String
    let options: [String]
    var isOpened: Bool = false
    
    init(title: String, options: [String], isOpened: Bool = false) {
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sections = [
            Section(title: "Section 1", options: [1,2,3].compactMap({return "Cell \($0)" })),
            Section(title: "Section 2", options: [1,2,3].compactMap({return "Cell \($0)" })),
            Section(title: "Section 3", options: [1,2,3].compactMap({return "Cell \($0)" })),
            Section(title: "Section 4", options: [1,2,3].compactMap({return "Cell \($0)" })),
            Section(title: "Section 5", options: [1,2,3].compactMap({return "Cell \($0)" })),
            Section(title: "Section 6", options: [1,2,3].compactMap({return "Cell \($0)" })),
            
        ]
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //!
        let section = sections[section]
        if section.isOpened {
            return section.options.count + 1
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = sections[indexPath.section].title
            cell.backgroundColor = .systemGray
        }
        else{
            cell.textLabel?.text = sections[indexPath.section].options[indexPath.row - 1]
            //çünkü bir ekledik yukarıda
            cell.backgroundColor = .systemGray6
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
        sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
            tableView.reloadSections([indexPath.section], with: .none)
        }
        else{
            print("tapped subcell")
        }
    }
}
