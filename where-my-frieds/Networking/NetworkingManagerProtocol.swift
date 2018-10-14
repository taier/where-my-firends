//
//  NetworkingManagerProtocol.swift
//  where-my-frieds
//
//  Created by Den on 10/14/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

protocol NetworkingManagerProtocol {
    static func getDataAll(onSucces: @escaping (_ itemsArray:Array<DataObject>) -> Void, onError: @escaping (_ error:String) -> Void)
    static func getDataSingle(userID:Int, onSucces: @escaping (_ itemsArray:Array<VehicleLocation>) -> Void, onError: @escaping (_ error:String) -> Void)
}
