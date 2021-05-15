//
//  MockURLSessionDataTask.swift
//  EasyBuyTests
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
  
  var completionHandler: (Data?, URLResponse?, Error?) -> Void
  var url: URLRequest
  
  init(completionHandler:
    @escaping (Data?, URLResponse?, Error?) -> Void,
       url: URLRequest,
       queue: DispatchQueue?) {
    if let queue = queue {
      self.completionHandler = { data, response, error in
        queue.async() {
          completionHandler(data, response, error)
        }
      }
    } else {
      self.completionHandler = completionHandler
    }
    self.url = url
    super.init()
  }
  
  var calledResume = false
  override func resume() {
    calledResume = true
  }
  
  var calledCancel = false
  override func cancel() {
    calledCancel = true
  }
}


