package com.applicationsec;

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication


@SpringBootApplication
open class Application0 {
  companion object {

    @JvmStatic
    fun main(args: Array<String>) {
      SpringApplication.run(Application0::class.java, *args)
    }
  }

}
