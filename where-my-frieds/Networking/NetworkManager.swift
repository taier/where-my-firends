//
//  NetworkManager.swift
//  where-my-frieds
//
//  Created by Den on 10/4/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

import Alamofire
import SwiftSoup

class NetworkManager: NSObject, NetworkingManagerProtocol, NetworkingGoogleManagerProtocol {
    
    static func getDataAll(onSucces: @escaping (_ itemsArray:Array<DataObject>) -> Void, onError: @escaping (_ error:String) -> Void)  {
        Alamofire.request(ENDPOINT_API_LIST_ALL).responseJSON { response in
            if let locationJSON = response.result.value as? [String: Any] {
                
                let dictionaryDecoder = DictionaryDecoder()
                var itemsArray:Array<DataObject> = [DataObject]()
                
                let data = locationJSON["data"] as! [[String: Any]]
                for dataItem in data {
                    
                    if let dataObject = try? dictionaryDecoder.decode(DataObject.self, from: dataItem) {
                        itemsArray.append(dataObject)
                    }
                }
                
                onSucces(itemsArray)
            } else {
                let errorString = NetworkManager.parseError(responseData: response.data!)
                onError(errorString)
            }
        }
    }
    
    static func getDataSingle(userID:Int, onSucces: @escaping (_ itemsArray:Array<VehicleLocation>) -> Void, onError: @escaping (_ error:String) -> Void)  {
        Alamofire.request(ENDPOINT_API_LIST_SINGLE + "\(userID)").responseJSON { response in
            if let vehicleData = response.result.value as? [String: Any] {
                
                let dictionaryDecoder = DictionaryDecoder()
                var itemsArray:Array<VehicleLocation> = [VehicleLocation]()
                
                let data = vehicleData["data"] as! [[String: Any]]
                for dataItem in data {
                    
                    guard !(dataItem["lat"] is NSNull) else {
                        onError("Lat is empty")
                        return
                    }
                    
                    guard !(dataItem["lon"] is NSNull) else {
                        onError("Lon is empty")
                        return
                    }
                    
                    let vehicleLocation = try! dictionaryDecoder.decode(VehicleLocation.self, from:dataItem)
                    itemsArray.append(vehicleLocation)
                }
                
                onSucces(itemsArray)
                
            } else {
                let errorString = NetworkManager.parseError(responseData: response.data!)
                onError(errorString)
            }
        }
    }
    
    static func getGoogleDirections(locationFrom:String, locationTo:String, onSucces: @escaping (_ points:String) -> Void, onError: @escaping (_ error:String) -> Void)  {
        
        /* set the parameters needed */
        let prefTravel = "driving" /* options are driving, walking, bicycling */
        /* Make the url */
        let url = URL(string: "\(ENDPOINT_GOOGLE_DIRECTIONS)json?origin=\(locationFrom)&destination=\(locationTo)&mode=\(prefTravel)&key=" + GOOGLE_ROUTE_KEY)!
        
        Alamofire.request(url).responseJSON { response in
            if let directionsData = response.result.value as? [String: Any] {
                
                /* only get the routes object */
                
                if let resData = directionsData["routes"] as? [[String: Any]] {
                    /* loop the routes */
                    if resData.count > 0 {
                        for rts in resData {
                            if let overViewPolyLine = rts["overview_polyline"] as? [String: Any] {
                                if let points = overViewPolyLine["points"] as? String {
                                    onSucces(points)
                                }
                            }
                        }
                    }
                }
            } else {
                let errorString = NetworkManager.parseError(responseData: response.data!)
                onError(errorString)
            }
        }
    }
    
    static private func parseError(responseData:Data) -> String {
        var errorString = String(data: responseData, encoding: String.Encoding.utf8)
        do {
            let doc: Document = try SwiftSoup.parse(errorString!)
            errorString = try doc.select("h1").text()
            print(errorString!)
        } catch {
            print("cant parse error")
        }
        
        return errorString!
    }
}
