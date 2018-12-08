//
//  ViewController.swift
//  ShareMe
//
//  Created by Julian Garcia on 11/14/18.
//  Copyright © 2018 Julian Garcia. All rights reserved.
//

import UIKit
import FirebaseUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        
        // get the default ui auth object
        let authUI = FUIAuth.defaultAuthUI()
        guard authUI != nil else{
            //log error
            return
        }
        
        //set ourselves as delegate
        authUI?.delegate = self
        
        //set a reference to the auth ui view controller
        let authViewController = authUI!.authViewController()
        
        //show it
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        //check if there is an error
        if error != nil{
            //log error
            return
        }
        
        //to grab the users id in the auth database
        //authDataResult?.user.uid
        
        performSegue(withIdentifier: "goHome", sender: self)
    }

}

