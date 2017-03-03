//

//  ViewController.swift

//  oktatestcase

//

//  Created by Andrew Van Beek on 2/22/17.

//  Copyright © 2017 Andrew Van Beek. All rights reserved.

//


import UIKit


var gameTimer: Timer!
var logOutTimer: Timer!
var logOut = "ready"


class ViewController: UIViewController {
    
  
    
    @IBOutlet weak var myWebView: UIWebView!
  
 
    
    
    
    
    func runTimedCode() {

        
                createAlert(title: "Are you still using the app?", message: "If you do not respond you will be logged out")
    }
    
    
    
    

    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let url = URL(string: "http://localhost:3000")
        
        myWebView.loadRequest(URLRequest(url: url!))
        
         var currentUrl = self.myWebView.request?.url
        
        if(logOut == "ready" && currentUrl != URL(string: "http://localhost:3000")){
            print("reached here")
        gameTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        }
    
        
    }
    
  
    

    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    func logThemOut() {
        if (logOut == "NA"){
            let cookie = HTTPCookie.self
            
            let cookieJar = HTTPCookieStorage.shared
            
            for cookie in cookieJar.cookies! {
                
                // print(cookie.name+"="+cookie.value)
                
                cookieJar.deleteCookie(cookie)
                
                var currentUrl = self.myWebView.request?.url
                
                print(currentUrl)
                
                let url = URL(string: "http://localhost:3000")
                logOut = "ready"
                self.myWebView.loadRequest(URLRequest(url: url!))
                
            }

        
        }
    }
    
    func createAlert (title:String, message:String){
        logOut = "NA"
        logOutTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(logThemOut), userInfo: nil, repeats: false)

        let popup = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        popup.addAction(UIAlertAction(title: "Not Done", style: UIAlertActionStyle.default, handler: { (action) in
            popup.dismiss(animated: true, completion: nil)
            logOut = "not done"
            logOutTimer.invalidate()
        }))
        
        popup.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in
            popup.dismiss(animated: true, completion: nil)
            logOut = "done"
            let cookie = HTTPCookie.self
            
            let cookieJar = HTTPCookieStorage.shared
            
            for cookie in cookieJar.cookies! {
                
                // print(cookie.name+"="+cookie.value)
                
                cookieJar.deleteCookie(cookie)
                
                var currentUrl = self.myWebView.request?.url
                
                print(currentUrl)
                
                let url = URL(string: "http://localhost:3000")
                logOut = "ready"
                self.myWebView.loadRequest(URLRequest(url: url!))
                
            }
        }))
        
        

        
        
        
        
                popup.dismiss(animated: true, completion: nil)
        
        self.present(popup, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
}
