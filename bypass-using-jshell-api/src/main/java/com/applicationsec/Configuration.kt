package com.applicationsec

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import reactor.core.publisher.Flux
import java.util.*

@Configuration
open class Configuration {

    @Bean
    open fun iamVulnerable(): Function<Flux<String>> =
        { flux: Flux<String> -> flux.map { value -> "you are vulnerable"  } }

}
