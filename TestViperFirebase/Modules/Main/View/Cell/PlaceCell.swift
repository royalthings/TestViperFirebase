//
//  PlaceCell.swift
//  TestViperFirebase
//
//  Created by Дмитрий Ага on 3/2/20.
//  Copyright © 2020 Дмитрий Ага. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {

   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var deskriptionLabel: UILabel!
   @IBOutlet weak var placeImageView: UIImageView!
   
   func selectPlaceImage(discipline: String) {
      if discipline == "Cafe" {
         placeImageView.image = UIImage(named: "cafe")
      } else if discipline == "Cinema" {
         placeImageView.image = UIImage(named: "cinema")
      } else if discipline == "Magazine" {
         placeImageView.image = UIImage(named: "magazine")
      } else if discipline == "Museum" {
         placeImageView.image = UIImage(named: "museum")
      } else if discipline == "Park" {
         placeImageView.image = UIImage(named: "park")
      } else if discipline == "Play park" {
         placeImageView.image = UIImage(named: "play_park")
      } else if discipline == "Restaurant" {
         placeImageView.image = UIImage(named: "restaurant")
      } else if discipline == "Statue" {
         placeImageView.image = UIImage(named: "statue")
      } else if discipline == "Theatre" {
         placeImageView.image = UIImage(named: "theatre")
      } else {
         placeImageView.image = UIImage(named: "iconsGO")
      }
   }

}
