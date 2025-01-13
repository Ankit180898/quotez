package com.example.quotez

import android.content.Context
import android.util.Log
import io.github.cdimascio.dotenv.dotenv
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject
import java.io.IOException

object QuoteFetcher {
    private const val API_URL = "https://famous-quotes4.p.rapidapi.com/random"
    private const val API_HOST = "famous-quotes4.p.rapidapi.com"

    fun fetchQuote(context: Context): String {
        // Load .env file
        val dotenv = dotenv {
            filename = ".env"
        }

        // Retrieve API key from .env
        val apiKey = dotenv["API_KEY"] ?: return "Error: API Key not found"

        return try {
            val client = OkHttpClient()
            val request = Request.Builder()
                .url(API_URL)
                .get()
                .addHeader("X-RapidAPI-Host", API_HOST)
                .addHeader("X-RapidAPI-Key", apiKey)
                .build()

            val response = client.newCall(request).execute()
            
            if (!response.isSuccessful) {
                Log.e("QuoteFetcher", "API response unsuccessful: ${response.code}")
                return "Error: API request failed"
            }

            val jsonData = response.body?.string()
            Log.d("QuoteFetcher", "Received JSON: $jsonData")

            if (jsonData != null) {
                val jsonObject = JSONObject(jsonData)
                val quote = jsonObject.getString("quote")
                val author = jsonObject.getString("author")
                "$quote - $author"
            } else {
                Log.e("QuoteFetcher", "Empty response body")
                "Error: Empty response"
            }
        } catch (e: IOException) {
            Log.e("QuoteFetcher", "Network error", e)
            "Error: Network issue"
        } catch (e: Exception) {
            Log.e("QuoteFetcher", "Error parsing quote", e)
            "Error: Unable to fetch quote"
        }
    }
}