//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Alex Yatsenko on 28.04.2020.
//  Copyright © 2020 Alexislog's Production. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    private var lastSeguedToGamevc: GameViewController?
    private var splitDetailViewlController: GameViewController? {
        return splitViewController?.viewControllers.last as? GameViewController
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowTheme",
            let themeIndex = (sender as? UIButton)?.tag else { return }
        if let gamevc = segue.destination as? GameViewController {
            gamevc.initialIndexTheme = themeIndex
            lastSeguedToGamevc = gamevc
        }
    }
    
    @IBAction func showThemevc(_ sender: UIButton) {
        let themeIndex = sender.tag
        if let splitDetailvc = splitDetailViewlController {
            splitDetailvc.indexTheme = themeIndex
        } else if let gamevc = lastSeguedToGamevc {
            gamevc.indexTheme = themeIndex
            navigationController?.pushViewController(gamevc, animated: true)
        } else {
            performSegue(withIdentifier: "ShowTheme", sender: sender)
        }
    }
    
}

extension ThemeChooserViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        return true
    }
}
