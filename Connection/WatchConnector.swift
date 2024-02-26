//
//  WatchConnector.swift
//  Ricettario
//
//  Created by Carmine De Micco on 21/02/24.
//

import Foundation
import WatchConnectivity
import Combine

struct Value:Codable{
    let path: String
    let value: String
}

class WatchConnector: ObservableObject{
    
    private var connectivityProvider: ConnectivityProvider
    
    @Published var testo: String = ""
    
    var valueModel: PassthroughSubject<Value, Never> = PassthroughSubject<Value, Never> ()
    var requests: AnyCancellable?
    
    init(){
        self.connectivityProvider = ConnectivityProvider(modelUpdates: valueModel)
        self.connectivityProvider.connect()
        
//        Switch sulle informaszioni che passo
        requests = valueModel.sink(receiveValue: {
            value in
            switch value.path{
            case "testo":
                self.testo = value.value
            default:
                print("Error")
                
            }
        })
        
    }
    
    
    func sendMessage(key: String, value: Any){
        let message = ["path": key, "value": value]
        connectivityProvider.send(message: message)
    }
}
                                   
