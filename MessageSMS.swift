//
//  MessageSMS.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import MessageUI

class MessageSMS: NSObject, MFMessageComposeViewControllerDelegate {

    func settingSMS(_ phoneNumber:String) -> MFMessageComposeViewController? {
        
        if MFMessageComposeViewController.canSendText() {
            
            let componentSMS = MFMessageComposeViewController()
            
            //seta o numero do telefone como default no menu
            componentSMS.recipients = [phoneNumber]
            
            componentSMS.messageComposeDelegate = self
            
            return componentSMS
        }
        return nil
        
    }
    
    //MARK: - Messagem Composite Delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
