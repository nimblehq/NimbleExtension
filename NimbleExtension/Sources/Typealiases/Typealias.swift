//  swiftlint:disable:this file_name
//  Typealias.swift
//  NimbleExtension
//
//  Created by Su T. Nguyen on 9/10/20.
//  Copyright © 2020 Nimble. All rights reserved.
//

import Alamofire

public typealias Headers = Alamofire.HTTPHeaders
public typealias Parameters = Alamofire.Parameters

public typealias Callback<T> = (T) -> Void
public typealias CompletionHandler = () -> Void
public typealias ResultCompletion<T> = (AFResult<T>) -> Void
public typealias EmptyResultCompletion = (EmptyRequestResult) -> Void

public typealias RequestAdapterProtocol = Alamofire.RequestAdapter
public typealias RequestRetrierProtocol = Alamofire.RequestRetrier
public typealias RequestInterceptorProtocol = Alamofire.RequestInterceptor
