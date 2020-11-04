package com.google.shinyay.controller

import com.google.shinyay.logger
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RestController

val cloudEventHeaders = listOf("ce-id", "ce-source", "ce-specversion", "ce-type", "ce-subject")

@RestController
class StorageEventController {

    @PostMapping("/")
    fun receiveMessage(@RequestBody body: Map<String, Any>,
                       @RequestHeader header: Map<String, String>): ResponseEntity<String> {
        cloudEventHeaders.forEach {
            if(header[it] == null) {
                val message = "Missing expected header: $it."
                logger.info(message)
                return ResponseEntity<String>(message, HttpStatus.BAD_REQUEST)
            }
        }
        val message = "Detected change in GCS bucket: ${header["ce-subject"]}"
        return ResponseEntity<String>(message, HttpStatus.OK)
    }
}