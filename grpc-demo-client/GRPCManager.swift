//
//  GRPCManager.swift
//  grpc-demo-client
//
//  Created by Alek Michelson on 9/12/23.
//

import Foundation
import NIO
import GRPC

class GRPCManager {
    static let shared = GRPCManager()
    
    let channel: GRPCChannel
    
    private init() {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        channel = try! GRPCChannelPool.with(
            target: .host("127.0.0.1", port: 9001),
            transportSecurity: .plaintext,
            eventLoopGroup: eventLoopGroup
        )
    }
    
    deinit {
        try! channel.close().wait()
    }
}
