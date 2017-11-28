//
//  ViewController.swift
//  Example
//
//  Created by Oleksandr Khymych on 27.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import UIKit
import KOLocalizedString

class ViewController: UIViewController {
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Outlet -
    //––––––––––––––––––––––––––––––––––––––––
    //Title Label
    @IBOutlet weak private var titleLabel:UILabel!
    //Buttons
    @IBOutlet weak private var enButton:UIButton!
    @IBOutlet weak private var ukButton:UIButton!
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Life cycle -
    //––––––––––––––––––––––––––––––––––––––––
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Settings -
    //––––––––––––––––––––––––––––––––––––––––
    private func settings(){
        self.localizedSettings()
        self.registerNotifications()
        self.enButton.addTarget(self, action: #selector(changeLocalized(_:)), for: .touchUpInside)
        self.ukButton.addTarget(self, action: #selector(changeLocalized(_:)), for: .touchUpInside)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Loclized Setting -
    //––––––––––––––––––––––––––––––––––––––––
    ///  Base settings localized  elements on area view controller
    private func localizedSettings(){
        //Example---------------------------------------------------------------------------
        self.titleLabel.text = KOLocalizedString("kTitleText")
        //Or
        //self.titleLabel.text = KOLocalizedString("kTitleText", comment: "this title text")
        ////--------------------------------------------------------------------------------
        self.enButton.setTitle(KOLocalizedString("kSetEnglish"), for: .normal)
        self.ukButton.setTitle(KOLocalizedString("kSetUkrainian"), for: .normal)
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Notification -
    //––––––––––––––––––––––––––––––––––––––––
    /// Register notifications
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLocalized), name: KODidUpdateDictionary, object: nil)
    }
    /// Function for notification
    @objc private func updateLocalized(){
        DispatchQueue.main.async {
            self.localizedSettings()
        }
    }
    //––––––––––––––––––––––––––––––––––––––––
    //MARK: - Actions -
    //––––––––––––––––––––––––––––––––––––––––
    /// Function for change localization
    @objc private func changeLocalized(_ sender:UIButton){
        KOSetLanguage(sender == enButton ? "en":"uk")
    }
}

