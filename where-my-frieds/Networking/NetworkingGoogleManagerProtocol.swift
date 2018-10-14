//
//  NetworkingGoogleManagerProtocol.swift
//  where-my-frieds
//
//  Created by Den on 10/14/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

protocol NetworkingGoogleManagerProtocol {
    static func getGoogleDirections(locationFrom:String, locationTo:String, onSucces: @escaping (_ points:String) -> Void, onError: @escaping (_ error:String) -> Void)
}
