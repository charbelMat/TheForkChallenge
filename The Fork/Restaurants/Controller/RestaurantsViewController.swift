//
//  ViewController.swift
//  The Fork
//
//  Created by Charbel Mattar on 08/03/2022.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var tableView: UITableView!
    var restaurants: Array = [RestaurantModel]()
    var sortButton: UIBarButtonItem!
    var sortingType = "name"
    let themeColor = UIColor(red: 102/255, green: 146/255, blue: 76/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "The Fork"
        self.view.backgroundColor = .white
        
        navigationController?.navigationBar.isHidden = false
        self.sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortAction))
        self.sortButton.isEnabled = false
        navigationItem.rightBarButtonItem = self.sortButton
        navigationItem.rightBarButtonItem?.tintColor = themeColor

        self.tableView = UITableView();
        self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: "restaurantCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
        RestaurantsDataModel.shared.fetchRestaurants { status in
            if(status == 1){
                self.reloadTableData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.tableView.frame = frame
    }
    func reloadTableData(){
        self.restaurants = RestaurantsDataModel.shared.getAllSortedBy(sortingType: self.sortingType)
        if (self.restaurants.count > 0){
            self.sortButton.isEnabled = true
        }
        self.tableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.restaurants.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120+tableView.frame.size.width*344/612
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath as IndexPath) as! RestaurantTableViewCell
        cell.setData(dataModel: self.restaurants[indexPath.section])
        cell.layoutSubviews()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    @objc func sortAction() {
        let alert = UIAlertController(title: "SORT BY", message: nil, preferredStyle: .alert)

        alert.view.tintColor = themeColor
        
        alert.addAction(UIAlertAction(title: "Name", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.sortingType = "name"
            self.reloadTableData()
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.sortingType = "rating"
            self.reloadTableData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
}

