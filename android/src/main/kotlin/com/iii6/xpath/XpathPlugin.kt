package com.iii6.xpath

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.seimicrawler.xpath.JXDocument

/** XpathPlugin */
class XpathPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var name: String = "com.ii6.xpath"
    private lateinit var document: JXDocument

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, name)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "parse" -> {
                parse(call, result)
            }
            "parseString" -> {
                parseString(call, result)
            }
            "parseList" -> {
                parseList(call, result)
            }
            "parseListTitleAndHref" -> {
                parseListTitleAndHref(call, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun parse(@NonNull call: MethodCall, @NonNull result: Result) {
        val html = call.argument<String>("html")
        document = JXDocument.create(html)

        result.success(true)
    }

    private fun parseString(@NonNull call: MethodCall, @NonNull result: Result) {
        val rule: String? = call.argument<String>("rule")
        val node = document.selNOne(rule)
        if (node.asString() != null) {
            result.success(node.asString())
        } else {
            result.success(null)
        }
    }

    private fun parseList(@NonNull call: MethodCall, @NonNull result: Result) {
        val rule: String? = call.argument<String>("rule")
        val node = document.selN(rule)
        val list: MutableList<String> = ArrayList()

        if (!node.isNullOrEmpty()) {
            for (value in node) {
                list.add(value.asString())
            }
            result.success(list)
        } else {
            result.success(null)
        }
    }

    private fun parseListTitleAndHref(@NonNull call: MethodCall, @NonNull result: Result) {
        val rule: String? = call.argument<String>("rule")
        val node = document.selN(rule)
        val list: MutableList<MutableList<String>> = ArrayList()

        if (!node.isNullOrEmpty()) {
            for (item in node) {
                val title = item.selOne("//text()").asString()
                val href = item.selOne("//@href").asString()
                list.add(mutableListOf(title, href))
            }
            result.success(list)
        } else {
            result.success(null)
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
