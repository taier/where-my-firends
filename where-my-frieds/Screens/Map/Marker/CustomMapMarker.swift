//
//  CustomMapMarker.swift
//  where-my-frieds
//
//  Created by Den on 10/8/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

import GoogleMaps

protocol CustomMapMarkerDelegate: class {
    func didTapNavigateTo(position: CLLocationCoordinate2D)
}

class CustomMapMarker: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var iboImgViewVehicle: UIImageView!
    @IBOutlet weak var iboLabelVehicleName: UILabel!
    @IBOutlet weak var iboViewColor: UIView!
    @IBOutlet weak var iboLabelVehicleAddress: UILabel!
    
    // MARK: - Variables
    weak var delegate: CustomMapMarkerDelegate?
    var position:CLLocationCoordinate2D?
    
    // MARK: - Life Cycle
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomMapMarker", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    static func loadNiB() -> CustomMapMarker? {
        let infoWindow = CustomMapMarker.instanceFromNib() as! CustomMapMarker
        return infoWindow
    }
    
    // MARK: - Actions
    func setupMarker(position:CLLocationCoordinate2D?, vehicleImgURL:URL, vehicleName:String, color:UIColor) {
        self.clearViews()
        
        self.position = position
        
        self.iboViewColor.backgroundColor = color
        self.iboLabelVehicleName.text = vehicleName
        
        self.getAdressFromPosition(position: position!) { (address) in
            self.iboLabelVehicleAddress.text = address
        }
        
        let imagePlaceholder = UIImage(named: "img_car_plaseholder")
        self.iboImgViewVehicle.kf.setImage(with: vehicleImgURL, placeholder: imagePlaceholder)
        
    }
    
    func clearViews() {
        self.iboViewColor.backgroundColor = UIColor.clear
        self.iboLabelVehicleAddress.text = ""
        self.iboLabelVehicleName.text = ""
        self.iboImgViewVehicle.image = nil
    }
    
    @IBAction func onButtonNavigate(_ sender: Any) {
        if(self.delegate != nil) {
            self.delegate?.didTapNavigateTo(position: self.position!)
        }
    }
    
    func getAdressFromPosition(position:CLLocationCoordinate2D, onSucces: @escaping (_ address:String) -> Void)  {
        
        let location: CLLocation =  CLLocation(latitude: position.latitude, longitude: position.longitude)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? String {
                print("Country :- \(country)")
                // City
                if let city = placeMark.addressDictionary!["City"] as? String {
                    print("City :- \(city)")
                    // State
                    if let state = placeMark.addressDictionary!["State"] as? String{
                        print("State :- \(state)")
                        // Street
                        if let street = placeMark.addressDictionary!["Street"] as? String{
                            print("Street :- \(street)")
                            let str = street
                            let streetNumber = str.components(
                                separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
                            
                            onSucces("\(country), \(city), \(street) \(streetNumber)")
                        }
                    }
                }
            }
        })
    }
}
