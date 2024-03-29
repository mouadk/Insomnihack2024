package com.applicationsec;

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication


@SpringBootApplication
open class BypassUsingJniInjection {
  companion object {

    @JvmStatic
    fun main(args: Array<String>) {
      SpringApplication.run(BypassUsingJniInjection::class.java, *args)
    }
  }

}

