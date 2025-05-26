//
//  netpWidgetLiveActivity.swift
//  netpWidget
//
//  Created by 조희용 on 5/26/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct netpWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct netpWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: netpWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension netpWidgetAttributes {
    fileprivate static var preview: netpWidgetAttributes {
        netpWidgetAttributes(name: "World")
    }
}

extension netpWidgetAttributes.ContentState {
    fileprivate static var smiley: netpWidgetAttributes.ContentState {
        netpWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: netpWidgetAttributes.ContentState {
         netpWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: netpWidgetAttributes.preview) {
   netpWidgetLiveActivity()
} contentStates: {
    netpWidgetAttributes.ContentState.smiley
    netpWidgetAttributes.ContentState.starEyes
}
