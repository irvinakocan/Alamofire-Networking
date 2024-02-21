//
//  ViewController.swift
//  Alamofire Networking
//
//  Created by Macbook Air 2017 on 21. 2. 2024..
//

import UIKit
import Alamofire

let API = "https://jsonplaceholder.typicode.com"
let GET_POST_ENDPOINT = "/posts/1"
let POST_ENDPOINT = "/posts"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getPost(completion: { post in
            if let post = post {
                print("You got post: ")
                print(post + "\n")
            }
        })
        postRequest()
    }
    
    private func getPost(completion: @escaping (String?) -> Void) {
        
        AF.request(API + GET_POST_ENDPOINT, method: .get).validate().response { response in
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            switch statusCode {
            case 200...299:
                guard let data = response.data,
                      let json = try? JSONSerialization.jsonObject(with: data) else {
                    return
                }
                if let postDictionary = json as? [String: Any] {
                    if let post = postDictionary["body"] as? String {
                        completion(post)
                    }
                }
            default:
                print("Error occured.")
                return
            }
        }
    }
    
    private func postRequest() {
        
        AF.request(API + POST_ENDPOINT, method: .post).validate().response { response in
            
            switch response.result {
            case .success(_):
                print("Your POST request was successful.")
            case .failure(_):
                print("Your POST request was not successful.")
            }
        }
    }
}

