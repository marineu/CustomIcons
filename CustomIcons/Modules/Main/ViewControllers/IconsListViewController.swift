//
//  IconsListViewController.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

class IconsListViewController: UIViewController {
    
    private var icons: Icons = [] {
        didSet {
            filteredIcons = icons
        }
    }
    private var filteredIcons: Icons = []
    
    private var iconsManager: IconsManager = IconsManager()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self

       return searchController
    }()
    
    private var searchOperationQueue = OperationQueue()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Icons"
        
        navigationItem.searchController = searchController
        
        addTableView()
        tableView.register(IconCell.self, forCellReuseIdentifier: "IconCell")
        
        searchOperationQueue.maxConcurrentOperationCount = 1
        
        iconsManager.loadIconsData { [weak self] iconsResponse in
            guard let self = self else { return }
            
            if let errorMessage = iconsResponse.errorMessage {
                AlertUtils.showErrorAlert(in: self, message: errorMessage)
                return
            }
            
            self.icons = iconsResponse.icons
            self.tableView.reloadData()
        }
    }
    
    //MARK: - setup UI
    
    private func addTableView() -> Void {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor
            .constraint(equalTo: view.leadingAnchor).isActive = true
        view.bottomAnchor
            .constraint(equalTo: tableView.bottomAnchor).isActive = true
        view.trailingAnchor
            .constraint(equalTo: tableView.trailingAnchor).isActive = true
    }
    
    //MARK: - search
    
    private func searchIcons(text: String) -> Void {
        let searchOperation = BlockOperation { [weak self] in
            guard let self = self else { return }
            
            self.filteredIcons = text.isEmpty ? self.icons :
                self.icons
                .filter({ $0.title.lowercased().contains(text.lowercased()) })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        searchOperationQueue.addOperation(searchOperation)
    }

}

//MARK: - UITableViewDataSource

extension IconsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        return filteredIcons.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell",
                                                 for: indexPath) as! IconCell
        
        cell.icon = filteredIcons[indexPath.row]
        
        return cell
    }
    
}

//MARK: - UISearchResultsUpdating

extension IconsListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if text.isEmpty && filteredIcons.count == icons.count {
            return
        }
        
        searchIcons(text: text)
    }
    
}
