package com.example.quotez

import android.content.ComponentName
import android.appwidget.AppWidgetManager
import android.widget.RemoteViews
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.quotez/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                val quote: String? = call.argument("quote")
                if (quote != null) {
                    updateWidget(quote)
                    result.success(null)
                } else {
                    result.error("QUOTE_ERROR", "No quote found", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun updateWidget(quote: String) {
        val appWidgetManager = AppWidgetManager.getInstance(context)
        val widget = appWidgetManager.getAppWidgetIds(ComponentName(context, QuoteWidgetProvider::class.java))
        val views = RemoteViews(packageName, R.layout.widget_layout)

        // Set the quote text in the widget
        views.setTextViewText(R.id.quote_text, quote)

        // Use the appropriate method to update the widget
        appWidgetManager.updateAppWidget(widget, views)
    }
}