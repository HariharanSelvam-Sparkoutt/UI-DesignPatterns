//
//  ViewController.swift
//  UI-DesignPatterns
//
//  Created by Sparkout on 12/06/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
        
        let viewModel = ViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            
            // Fetch initial data
            fetchData()
        }
        
    func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                print("Data fetched, reloading table view")
                self.tableView.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numberOfItems()
               print("Number of items:", count)
        return viewModel.numberOfItems()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let item = viewModel.item(at: indexPath.row)
        // Configure cell with item details
        cell.titleLabel.text = item.title
        // Set image using Kingfisher or similar library
        cell.descriptionLabel.text = item.description
        cell.categoryLabel.text = "Category: \(item.category)"
        cell.priceLabel.text = "Price: $\(item.price)"
        cell.ratingLabel.text = "\(item.rating)"
        
        // Perform image loading asynchronously
            DispatchQueue.global().async {
                if let url = URL(string: item.image), let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        // Switch back to the main thread to update UI
                        DispatchQueue.main.async {
                            cell.itemImageView.contentMode = .scaleToFill
                            cell.itemImageView.image = image
                        }
                    }
                }
            }
        print("Configuring cell for item at index:", indexPath.row)
        return cell
    }
}
