//
//  MinhaLocalizacaoAtualMaps.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import MapKit

class MinhaLocalizacaoAtualMaps: NSObject {
    
    func getLocalizacao(_ mapa:MKMapView) -> MKUserTrackingButton {
        
        let buttonLocallizacaoAutal = MKUserTrackingButton(mapView: mapa)
        
        //Vamos configurar a posicao do botao no mapa
        buttonLocallizacaoAutal.frame.origin.x = 10
        buttonLocallizacaoAutal.frame.origin.y = 10
        
        return buttonLocallizacaoAutal
        
    }

    
}
