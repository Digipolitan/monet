//
//  ViewController.swift
//  MonetSample-tvOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import Monet

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    static let themes = [
        "default",
        "other",
        "custom"
    ]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: Notification.Name.MonetThemeDidChange, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.MonetThemeDidChange, object: nil)
    }

    @objc func themeDidChange() {
        self.view.redrawAppearance()
    }

    @IBAction func btnClickedTvOS(_ sender: UIButton!) {
        let rand: Int = Int.random(in: 0 ... 2)
        Monet.shared.theme = try? Theme.from(jsonFile: ViewController.themes[rand])
    }
}
