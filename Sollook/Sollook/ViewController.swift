//
//  ViewController.swift
//  Sollook
//
//  Created by 박용범 on 2020/06/25.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import CoreNFC

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    

    @IBOutlet weak var NFCText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var nfcSession: NFCNDEFReaderSession?
    var word = "None"
    
    @IBAction func scanBtn(_ sender: UIButton) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.begin()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The Session was invalidated: \(error.localizedDescription) \nNFC Ready : \(nfcSession!.isReady)")
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages[0].records{
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8) ?? "Formate not supported"
        }
        DispatchQueue.main.async {
            self.NFCText.text = result
        }
    }

    
    
}

