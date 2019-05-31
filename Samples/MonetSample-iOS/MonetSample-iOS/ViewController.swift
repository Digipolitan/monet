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

    fileprivate static let themes = [
        "default",
        "other",
        "custom"
    ]

    fileprivate var monetThemeDidChangeObserver: Any?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeMonetThemeDidChangeNotification()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.unsubscribeMonetThemeDidChangeNotification()
    }

    func subscribeMonetThemeDidChangeNotification() {
        self.unsubscribeMonetThemeDidChangeNotification()
        self.monetThemeDidChangeObserver = NotificationCenter.default.addObserver(forName: Notification.Name.MonetThemeDidChange, object: nil, queue: nil) { [weak self] _ in
            guard let target = self else {
                return
            }
            target.view.redrawAppearance()
        }
    }

    func unsubscribeMonetThemeDidChangeNotification() {
        guard let observer = self.monetThemeDidChangeObserver else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
        self.monetThemeDidChangeObserver = nil
    }

    @IBAction func btnClicked(_ sender: UIButton!) {
        let rand: Int = Int.random(in: 0 ... 2)
        Monet.shared.theme = try? Theme.from(jsonFile: ViewController.themes[rand])
    }

    deinit {
        self.unsubscribeMonetThemeDidChangeNotification()
    }
}
