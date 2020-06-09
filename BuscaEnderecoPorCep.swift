//
//  BuscaEnderecoPorCep.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import Alamofire

class BuscaEnderecoPorCep: NSObject {

    var cep = ""
    lazy var url = "https://viacep.com.br/ws/\(cep)/json/"
    
    func consultaCep(pCEP:String, sucesso:@escaping(_ response:CepResponse) -> Void, fail:@escaping(_ error:Error) -> Void) {
        
        self.cep = pCEP
        
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            
            if response.result.isSuccess{
                
                guard let result = response.result.value as? Dictionary<String,String> else {return}
                let cepResponse = CepResponse(result)
                sucesso(cepResponse)
                
            } else {
                
                fail(response.result.error!)
            
            }
            
        }

        
    }
    
}
