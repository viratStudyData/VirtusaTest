//
//  APIManager.swift
//  VirtusaTest
//
//  Created by Virat on 10/12/23.
//

import Foundation
import UIKit

class APIManager : NSObject {
    
    typealias Completion = (Response) -> ()
    static let shared = APIManager()
    private lazy var httpClient: HTTPClient = HTTPClient()
    
    func fetchRequest(with api : Router , completion : @escaping Completion )  {
        
        if api.isLoaderNeeded() {
            self.showLoader()
        }
        
        httpClient.fetchRequest(withApi: api, success: {[weak self] (dictionary, responseData) in
            self?.dissmissLoader()
            guard let response = dictionary, response is [String : Any], let data = responseData else {
                completion(Response.failure(ResponseCodes.noResponse.rawValue,ResponseMessages.somethingWentWrong()))
                return
            }
            
            let object : AnyObject?
            object = api.handle(responseObj: data)
            completion(Response.success(object))
            return

            }, failure: {[weak self] (error) in
                self?.dissmissLoader()
                
                if error?._code == NSURLErrorTimedOut || error?._code == NSURLErrorCannotConnectToHost || error?._code == NSURLErrorCannotFindHost {
                    completion(Response.failure(ResponseCodes.noResponse.rawValue,ResponseMessages.serverNotReachable()))
                    
                } else if error?._code == NSURLErrorNetworkConnectionLost || error?._code == NSURLErrorNotConnectedToInternet || error?._code == ResponseCodes.noInternet.rawValue {
                    completion(Response.failure(ResponseCodes.noInternet.rawValue,ResponseMessages.noInternetConnection()))
                    
                } else {
                    completion(Response.failure(error?._code ?? 0,(error?.localizedDescription ?? "")))
                    
                }
        })
    }
    
    
    
    //MARK: HUD
    func showLoader() {
        DispatchQueue.main.async {
            guard let vc = self.getTopVC() else { return }
            LoaderView.addOn(View: vc.view)
        }
    }
    
    func dissmissLoader() {
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                LoaderView.hide()
            }
        }
    }
    
    func getTopVC() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }

            return topController
        }
        return nil
    }
}
