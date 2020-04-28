//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Alex Yatsenko on 28.04.2020.
//  Copyright © 2020 Alexislog's Production. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowTheme",
            let themeIndex = (sender as? UIButton)?.tag else { return }
        if let gamevc = segue.destination as? GameViewController {
            gamevc.initialIndex = themeIndex
        }
    }
    
    @IBAction func showThemevc(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowTheme", sender: sender)
    }
    
}
