package com.freeletics.coredux.log.android

import android.util.Log
import com.freeletics.coredux.log.common.LoggerLogSink
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.GlobalScope

/**
 * Provides [com.freeletics.coredux.LogSink] implementation, that uses Android [Log] class to send log output.
 *
 * @param scope to receive incoming log messages, default is [GlobalScope]
 */
class AndroidLogSink(
    scope: CoroutineScope = GlobalScope
) : LoggerLogSink(scope) {
    override fun debug(
        tag: String,
        message: String,
        throwable: Throwable?
    ) {
        Log.d(tag, message, throwable)
    }

    override fun info(
        tag: String,
        message: String,
        throwable: Throwable?
    ) {
        Log.i(tag, message, throwable)
    }

    override fun warning(
        tag: String,
        message: String,
        throwable: Throwable?
    ) {
        Log.w(tag, message, throwable)
    }
}
