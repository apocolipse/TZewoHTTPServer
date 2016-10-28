//
//  TZewoHTTPServer.swift
//  TZewoHTTPServer
//
//  Created by Christopher Simpson on 10/28/16.
//
//

import HTTPServer
import Thrift
import Foundation


open class TZewoHTTPServer<InProtocol: TProtocol, OutProtocol: TProtocol, Processor: TProcessor, Service> where Processor.Service == Service {
  private var server: Server?
  var serviceHandler: Service
  
  public init(address: String? = nil,
              path: String? = nil,
              port: Int,
              service: Service,
              inProtocol: InProtocol.Type,
              outProtocol: OutProtocol.Type?=nil,
              processor: Processor.Type) throws {

    // set service handler
    self.serviceHandler = service
    
    
    let router = BasicRouter { route in
      route.post("/") { request in
        // Get body bytes
        var bytes: [Byte] = []
        if case .buffer(let body) = request.body {
          bytes = body.bytes
        } else {
          return Response(status: .badRequest)
        }

        // Setup response
        var response = Response()
        response.headers = ["content-type": "application/x-thrift"]

        // Setup transports
        let itrans = TMemoryBufferTransport()
        itrans.reset(readBuffer: Data(bytes: bytes))
        let otrans = TMemoryBufferTransport(flushHandler: { trans, buff in
          let byteArray = buff.withUnsafeBytes {
            Array<UInt8>(UnsafeBufferPointer(start: $0, count: buff.count))
          }
          response.status = .ok
          response.body = .buffer(Buffer(byteArray))
        })
        
        // Setup protocols
        let inproto = InProtocol(on: itrans)
        let outproto = OutProtocol(on: otrans)
        
        // Process
        do {
          let proc = Processor(service: self.serviceHandler)
          try proc.process(on: inproto, outProtocol: outproto)
          try otrans.flush()
        } catch {
          response.status = .badRequest
        }
        
        return response
      }
    }

    self.server = try? Server(port: port, responder: router)
  }
  
  public func serve() throws {
    try self.server?.start()
  }
}
