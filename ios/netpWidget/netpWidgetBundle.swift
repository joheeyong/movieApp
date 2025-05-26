//
//  netpWidgetBundle.swift
//  netpWidget
//
//  Created by 조희용 on 5/26/25.
//

import WidgetKit
import SwiftUI

@main
struct netpWidgetBundle: WidgetBundle {
    var body: some Widget {
        netpWidget()
        netpWidgetControl()
        netpWidgetLiveActivity()
    }
}
