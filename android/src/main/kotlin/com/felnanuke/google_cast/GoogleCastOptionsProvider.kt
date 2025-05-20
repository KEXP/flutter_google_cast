package com.felnanuke.google_cast
import android.content.Context
import com.google.android.gms.cast.framework.CastOptions
import com.google.android.gms.cast.framework.OptionsProvider
import com.google.android.gms.cast.framework.SessionProvider



 class GoogleCastOptionsProvider : OptionsProvider {
     companion object {
         private var _options: CastOptions? = null

         var options: CastOptions
             get() = _options ?: defaultOptions()
             set(value) {
                 _options = value
             }

         private fun defaultOptions(): CastOptions {
             return CastOptions.Builder()
                 .setReceiverApplicationId("CC1AD845")  // Default Media Receiver
                 .build()
         }
     }

    override fun getCastOptions(context: Context): CastOptions {

        return options
    }

    override fun getAdditionalSessionProviders(p0: Context): MutableList<SessionProvider>? {
        return null
    }
}