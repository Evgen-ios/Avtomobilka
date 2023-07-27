//
//  Session + Ext.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import Foundation
import Pulse
import Alamofire
import Moya

extension MoyaProvider {
    final class func loggedByPulseSession() -> Session {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        return Session(configuration: configuration, startRequestsImmediately: false, eventMonitors: [MoyaNetworkLogger(logger: .init())])
    }
}

struct MoyaNetworkLogger: EventMonitor {
    let logger: NetworkLogger

    public func request(_ request: Request, didCreateTask task: URLSessionTask) {
        logger.logTaskCreated(task)
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        logger.logDataTask(dataTask, didReceive: data)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        logger.logTask(task, didFinishCollecting: metrics)
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        logger.logTask(task, didCompleteWithError: error)
    }
}
