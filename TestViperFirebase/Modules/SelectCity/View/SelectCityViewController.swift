//
//  SelectCitySelectCityViewController.swift
//  TestViperFirebase
//
//  Created by agadu on 22/04/2020.
//  Copyright © 2020 TestViperFirebase. All rights reserved.
//

import UIKit

class SelectCityViewController: UIViewController, SelectCityViewInput {
   
   
   @IBOutlet weak var cityTableView: UITableView!
   
   var output: SelectCityViewOutput!
   
   // MARK: Life cycle
   override func viewDidLoad() {
      super.viewDidLoad()
      output.viewIsReady()
   }
   
   
   // MARK: SelectCityViewInput
   func setupInitialState() {
   }
   
   
   @IBAction func backAction(_ sender: Any) {
      output.dismiss()
   }
   
   
}

extension SelectCityViewController: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Constants.cityListMenu.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell else { return UITableViewCell() }
      cell.cityLabel.text = Constants.cityListMenu[indexPath.row]
      cell.accessoryType = .none
      cell.selectionStyle = .none
      if UserDefaults.standard.string(forKey: Constants.Keys.userCity) == Constants.cityListMenu[indexPath.row] {
         cell.accessoryType = .checkmark
      }
      return cell
   }
}

extension SelectCityViewController: UITableViewDelegate {
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let city = Constants.cityListMenu[indexPath.row]
      UserDefaults.standard.set(city, forKey: Constants.Keys.userCity)
      tableView.reloadData()
   }
   
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      if let cell = tableView.cellForRow(at: indexPath) {
         cell.accessoryType = .none
      }
      
   }
}
