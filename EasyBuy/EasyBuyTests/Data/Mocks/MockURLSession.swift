//
//  MockURLSession.swift
//  EasyBuyTests
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import Foundation

class MockURLSession: URLSession {
  
  var queue: DispatchQueue? = nil
  
  func givenDispatchQueue() {
    queue = DispatchQueue(label: "com.mocksession.mockSession")
  }
  
  override func dataTask(
    with url: URLRequest,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
      -> URLSessionDataTask {
        return MockURLSessionDataTask(completionHandler: completionHandler,
                                      url: url,
                                      queue: queue)
  }
}
