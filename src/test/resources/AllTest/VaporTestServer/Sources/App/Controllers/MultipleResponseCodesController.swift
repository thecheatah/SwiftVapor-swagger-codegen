//
//  MultipleResponseCodesController.swift
//  App
//
//  Created by Ravneet Singh on 3/31/19.
//

import Vapor
import VaporTestInterface

class MultipleResponseCodesController: MultipleResponseCodesApiDelegate {
  typealias AuthType = SampleAuthType
  func multipleResponseCodes(with req: Request, body: MultipleResponseCodeRequest) throws -> EventLoopFuture<multipleResponseCodesResponse> {
    switch body.responseCode {
    case MultipleResponseCodeRequest.ResponseCode._200:
      return req.eventLoop.makeSucceededFuture(.http200)
    case MultipleResponseCodeRequest.ResponseCode._201:
      return req.eventLoop.makeSucceededFuture(.http201(SimpleObject(simpleString: "Simple String", simpleNumber: 44.22, simpleInteger: 44, simpleDate: Date(), simpleEnumString: ._1, simpleBoolean: false, simpleArray: ["Hi!"])))
    case MultipleResponseCodeRequest.ResponseCode._401:
      return req.eventLoop.makeSucceededFuture(.http401)
    case MultipleResponseCodeRequest.ResponseCode._500:
      return req.eventLoop.makeSucceededFuture(.http500)
    }
  }
}
