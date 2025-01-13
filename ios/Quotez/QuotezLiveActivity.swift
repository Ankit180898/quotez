//
//  QuotezLiveActivity.swift
//  Quotez
//
//  Created by Ankit Kumar on 1/13/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct QuotezAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct QuotezLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: QuotezAttributes.self) { context in
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

extension QuotezAttributes {
    fileprivate static var preview: QuotezAttributes {
        QuotezAttributes(name: "World")
    }
}

extension QuotezAttributes.ContentState {
    fileprivate static var smiley: QuotezAttributes.ContentState {
        QuotezAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: QuotezAttributes.ContentState {
         QuotezAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: QuotezAttributes.preview) {
   QuotezLiveActivity()
} contentStates: {
    QuotezAttributes.ContentState.smiley
    QuotezAttributes.ContentState.starEyes
}
