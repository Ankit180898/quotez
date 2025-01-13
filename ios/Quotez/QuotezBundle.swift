//
//  QuotezBundle.swift
//  Quotez
//
//  Created by Ankit Kumar on 1/13/25.
//

import WidgetKit
import SwiftUI

@main
struct QuotezBundle: WidgetBundle {
    var body: some Widget {
        Quotez()
        QuotezControl()
        QuotezLiveActivity()
    }
}
