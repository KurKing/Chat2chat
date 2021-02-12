//
//  NetworkMonitor.swift
//  Chat2chat
//
//  Created by Oleksiy on 12.02.2021.
//

import Network

class NetworkMonitor {
    
    let monitor = NWPathMonitor()
    var isNetworkAvailable: Bool { status == .satisfied }
    
    private var status: NWPath.Status = .requiresConnection
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
        }
        
        let queue = DispatchQueue(label: "Network Monitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
