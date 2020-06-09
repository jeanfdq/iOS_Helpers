//
//  GetLatLong_Endereco.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import MapKit

class GetLatLong_Endereco: NSObject {

    func getLatLong_Anddress(_ address:String, local:@escaping(_ lat_long:CLPlacemark?) -> Void){
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (listLatLong, error) in
            
            guard let LatLong = listLatLong?.first else {return}
            local(LatLong)
        }
        
    }
    
    func pinoLocalizacaoAtual(_ mapa:MKMapView) -> MKUserTrackingButton {
        
        let buttonLocallizacaoAutal = MKUserTrackingButton(mapView: mapa)
        
        //Vamos configurar a posicao do botao no mapa
        buttonLocallizacaoAutal.frame.origin.x = 10
        buttonLocallizacaoAutal.frame.origin.y = 10
        
        return buttonLocallizacaoAutal
        
    }
    
}
