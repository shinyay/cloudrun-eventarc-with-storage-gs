package com.google.shinyay.controller

import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RestController

val cloudEventHeaders = listOf("ce-id", "ce-source", "ce-type", "ce-specversion")

@RestController
class StorageEventController {

    @PostMapping("/")
    fun receiveMessage(@RequestBody body: Map<String, Any>,
                       @RequestHeader header: Map<String, String>) {

    }
}