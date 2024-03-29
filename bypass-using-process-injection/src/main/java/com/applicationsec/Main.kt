package com.applicationsec;

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication


@SpringBootApplication
open class BypassUsingProcessInjection {
  companion object {

    @JvmStatic
    fun main(args: Array<String>) {
      SpringApplication.run(BypassUsingProcessInjection::class.java, *args)
    }
  }

}
