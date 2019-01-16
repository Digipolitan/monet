//
//  ViewController.swift
//  MonetSample-iOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import Monet

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!

    func setupUI(theme: Theme) {
        //self.label.setAppearance(theme.appearances["sample"])
     //   self.view.setAppearance(theme.scene)
     //   self.button.setAppearance(theme.action)
      //  self.title = theme.identifier
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnClicked(_ sender: UIButton!) {
     //   let manager = ThemeManager.shared
        let rand: Int = Int(arc4random())
      //  manager.current = manager.themes[rand % manager.themes.count]
      //  self.setupUI(theme: ThemeManager.shared.current)
    }
}
