//
//  String+Extensions.swift
//  TestViperFirebase
//
//  Created by Дмитрий Ага on 4/8/20.
//  Copyright © 2020 Дмитрий Ага. All rights reserved.
//

import Foundation

extension String {
   
   static func filteredCharacters(enteredText: String) -> String {
      let allowedCharacters = CharacterSet(charactersIn:" 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя-_@.").inverted
      let components = enteredText.components(separatedBy: allowedCharacters)
      let filtered = components.joined(separator: "")
      return filtered
   }
}

