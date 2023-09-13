//
//  ContentView.swift
//  grpc-demo-client
//
//  Created by Alek Michelson on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button("Womp") {
                viewModel.create()

            }
        }
        .padding()

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

@MainActor class ContentViewModel: ObservableObject {
    func create() {
        DispatchQueue.main.async {
            let client: Store_InventoryNIOClient = .init(channel: GRPCManager.shared.channel)
            
            do {
                let _ = try client.add(.with { req in
                    var storeID = Store_ItemIdentifier()
                    storeID.sku = "wompwomp2"
                    req.identifier = storeID
                 
                    var stock = Store_ItemStock()
                    stock.price = 0.01
                    stock.quantity = 69
                    req.stock = stock
                })
                    .response
                    .wait()
                
                print("Success!!")
            } catch {
                print("Womp womp... got error: \(error)")
            }
           
        }
        
    }
}
