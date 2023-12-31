//
//  InfoViewController.swift
//  WeatherApp
//
//  Created by rguttula on 13/03/21.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initilSetup()
        // Do any additional setup after loading the view.
    }
    func initilSetup()
    {
        self.navigationItem.title = "How To Use"
        let htmlPath = Bundle.main.path(forResource: "HowToUse", ofType: "htm")
        let htmlUrl = URL(fileURLWithPath: htmlPath!, isDirectory: false)
        webview.loadFileURL(htmlUrl, allowingReadAccessTo: htmlUrl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
