//
//  GraphQLQuery.swift
//  Traeger-Code-Challenge
//
//  Created by Kyle Stewart on 1/8/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

/// Objects that dicate what fields a query should contain, and how that data should be laid out
protocol GraphQLQuery {
    var queryData: Data { get }
}

/// Objects used in parsing GraphQL Response, and therefore should dictate what fields to query
protocol GraphQLObject {
    static var fieldsQuery: String { get }
}
