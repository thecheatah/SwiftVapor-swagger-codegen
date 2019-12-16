import Vapor
// QueryParametersApiDelegate.swift
//
// Generated by vapor-server-codegen
// https://github.com/thecheatah/SwiftVapor-swagger-codegen
// Template Input: /APIs.QueryParameters


public enum queryParametersResponse: ResponseEncodable {
  case http200(QueryParametersResponse)

  public func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
    switch self {
    case .http200(let content):
      return content.encodeResponse(for: request).map { (response: Response) -> (Response) in
        response.status = HTTPStatus(statusCode: 200)
        return response
      }
    }
  }
}

public protocol QueryParametersApiDelegate {
  associatedtype AuthType
  /**
  GET /query/parameter
  Query parameter test */
  func queryParameters(with req: Request, param1: String, param2: Int?) throws -> EventLoopFuture<queryParametersResponse>
}
