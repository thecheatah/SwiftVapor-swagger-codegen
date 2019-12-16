import Vapor
import RoutingKit

// routes.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: 

extension String {
  var asPathComponents: [PathComponent] {
    return self.split(separator: "/").map {
      if $0.starts(with: "{") && $0.hasSuffix("}") {
        let start = $0.index($0.startIndex, offsetBy: 1)
        let end = $0.index($0.endIndex, offsetBy: -1)
        return PathComponent.parameter(String($0[start..<end]))
      } else {
        return PathComponent.constant(.init($0))
      }
    }
  }
}

public protocol AuthenticationMiddleware: Middleware {
  associatedtype AuthType: Authenticatable
  func authType() -> AuthType.Type
}

//Used when auth is not used
public class DummyAuthType: Authenticatable {}

public func routes<dataModel: DataModelApiDelegate, formData: FormDataApiDelegate, headers: HeadersApiDelegate, multipleResponseCodes: MultipleResponseCodesApiDelegate, pathParsing: PathParsingApiDelegate, queryParameters: QueryParametersApiDelegate>
  (_ app: Application, dataModel: dataModel, formData: formData, headers: headers, multipleResponseCodes: multipleResponseCodes, pathParsing: pathParsing, queryParameters: queryParameters)
  throws
  where dataModel.AuthType == DummyAuthType.Type, formData.AuthType == DummyAuthType.Type, headers.AuthType == DummyAuthType.Type, multipleResponseCodes.AuthType == DummyAuthType.Type, pathParsing.AuthType == DummyAuthType.Type, queryParameters.AuthType == DummyAuthType.Type
  {
  //for dataModel
  app.on(.POST, "/schema/referenced/object".asPathComponents) { (request: Request) -> EventLoopFuture<referencedObjectResponse> in
    let body = try request.content.decode(SimpleObject.self)
    return try dataModel.referencedObject(with: request, body: body)
  }
  //for formData
  app.on(.POST, "/form/request".asPathComponents) { (request: Request) -> EventLoopFuture<formRequestResponse> in
    let simpleString = try request.content.get(SimpleString.self, at: "simpleString")
    let simpleNumber = try request.content.get(SimpleNumber.self, at: "simpleNumber")
    let simpleInteger = try request.content.get(SimpleInteger.self, at: "simpleInteger")
    let simpleDate = try request.content.get(SimpleDate.self, at: "simpleDate")
    let simpleEnumString = try request.content.get(SimpleEnumString.self, at: "simpleEnumString")
    let simpleBoolean = try request.content.get(SimpleBoolean.self, at: "simpleBoolean")
    let simpleArray = try request.content.get([SimpleString].self, at: "simpleArray")
    return try formData.formRequest(with: request, simpleString: simpleString, simpleNumber: simpleNumber, simpleInteger: simpleInteger, simpleDate: simpleDate, simpleEnumString: simpleEnumString, simpleBoolean: simpleBoolean, simpleArray: simpleArray)
  }
  //for headers
  app.on(.GET, "/headers/in-request".asPathComponents) { (request: Request) -> EventLoopFuture<requestHeadersResponse> in
    if !request.headers.contains(name: "x-example-required-header") {
      throw Abort(.badRequest, reason: "Missing header: x-example-required-header")
    }
    let xExampleRequiredHeader = request.headers["x-example-required-header"][0]
    let xExampleArrayHeader = request.headers["x-example-array-header"]
    return try headers.requestHeaders(with: request, xExampleRequiredHeader: xExampleRequiredHeader, xExampleArrayHeader: xExampleArrayHeader)
  }
  app.on(.GET, "/headers/in-response".asPathComponents) { (request: Request) -> EventLoopFuture<responseHeadersResponse> in
    return try headers.responseHeaders(with: request)
  }
  //for multipleResponseCodes
  app.on(.POST, "/multiple/response/codes".asPathComponents) { (request: Request) -> EventLoopFuture<multipleResponseCodesResponse> in
    let body = try request.content.decode(MultipleResponseCodeRequest.self)
    return try multipleResponseCodes.multipleResponseCodes(with: request, body: body)
  }
  //for pathParsing
  app.on(.GET, "/path/multiple/depth".asPathComponents) { (request: Request) -> EventLoopFuture<multipleDepthResponse> in
    return try pathParsing.multipleDepth(with: request)
  }
  app.on(.GET, "/path/{param1}/and/{param2}".asPathComponents) { (request: Request) -> EventLoopFuture<multipleParameterResponse> in
    guard let param1 = request.parameters.get("param1", as: String.self) else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing parameter param1")
    }
    guard let param2 = request.parameters.get("param2", as: String.self) else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing parameter param2")
    }
    return try pathParsing.multipleParameter(with: request, param1: param1, param2: param2)
  }
  app.on(.GET, "/".asPathComponents) { (request: Request) -> EventLoopFuture<rootPathResponse> in
    return try pathParsing.rootPath(with: request)
  }
  app.on(.GET, "/path-single-depth".asPathComponents) { (request: Request) -> EventLoopFuture<singleDepthResponse> in
    return try pathParsing.singleDepth(with: request)
  }
  app.on(.GET, "/path/{param1}".asPathComponents) { (request: Request) -> EventLoopFuture<singleParameterResponse> in
    guard let param1 = request.parameters.get("param1", as: String.self) else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing parameter param1")
    }
    return try pathParsing.singleParameter(with: request, param1: param1)
  }
  //for queryParameters
  app.on(.GET, "/query/parameter".asPathComponents) { (request: Request) -> EventLoopFuture<queryParametersResponse> in
    let param1Optional = try? request.query.get(String.self, at: "param1")
    guard let param1 = param1Optional else {
      throw Abort(HTTPResponseStatus.badRequest, reason: "Missing query parameter param1")
    }
    let param2 = try? request.query.get(Int.self, at: "param2")
    return try queryParameters.queryParameters(with: request, param1: param1, param2: param2)
  }
}

