//
//  URLRequest+Extensions.swift
//  Infra
//
//  Created by Lucas Daniel on 22/09/20.
//  Copyright © 2020 Lucas. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        let urla = URL(string: "")!
        Observable.from(urla)
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
        }.map { data -> T? in
            return try? JSONDecoder().decode(T.self, from: data)
        }.asObservable()
    }
}
