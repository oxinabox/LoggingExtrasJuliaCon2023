




# Logging in Julia






## Logging stdlib and LoggingExtras.jl


.row[ .col[ .image-50[![JuliaLogging](assets/logo.png)] ] ] .row[ .col[     **Frames White** (she/her) <br>     EDA & Compiler Engineer <br>


.image-40[![JuliaHub](assets/juliahub.png)] ] .col[ **JuliaCon** <br> 2023<br> Boston<br> ]  ]




---






## Can you chose a more difficult location for a conference?


.row[ .col[ .image-100[![Flight map](assets/map.svg)] ] .col[ Yes, if you chose Bermuda.


  * It took me over 32 hours to get here.
  * 18,700 km in great circle distance


] ] The problem is the remoteness of Boston, and not of Perth.


---






# History and Credit


  * LoggingExtras initially created in 2018 shortly after Julia 1.0 and the new Logging stdlib
  * The Julia 1.0 logging stdlib was largely created by **Claire Foster**
  * Thanks also to other contributors, in particular **Fredrik Ekre** and **Jacob Quinn**


--






# Who is logging for ?


Logging is a servant with many masters


  * Operations Team monitoring production enviroment.

      * Probably using some tool liked Cloudwatch or SumoLogic work with the logs
  * The developer
  * The end user


---






# What is log plumbing?


.image-100[![log plumbing](assets/plumbing.svg)]


Direct the right content to the right place.


---






# Future Work






### What is wrong with our logging system?


---






## We have no solution for deprecation warnings


---






## No distinction between data and metadata


Often you want to talk to the logger at the call-site. The emergent way of doing this has been via setting keys.


For example:


```julia
for ii in 1:100
    @info "this mesage will be shown only 3 times" max-log=3
end
```


---






## Console Logger is very complex


The `ConsoleLogger` is the opposite of a compositional logger.


It is a very nice sink, with lots of sensible and good rendering. It has the configurable `meta_formatter` for coloring and adding suffixed and prefixed to messages. It has code for shortenning long values, and for justification of text.


It does filtering based on the `maxlog` handle and the `id`.


A lot of this other loggers would like to reuse. Most of it wouldn't be enhanced by merely rewriting it as the composion of LoggingExtras types.


---






## `JULIA_DEBUG` environment variable is not quite right


This is an enviroment variable that takes a list of package names to always show no matter what the `min_enabled_level(logger)` returns.


It's not part of the `ConsoleLogger` – it actually bypasses the logging system almost entirely.


It's not free and it can't be turned off. Takes about least 20ns to check an env that doesn't exist. This means you can't put logging in a tight loop, since no matter how you configure your logging setup you can't disable this check.


See: https://github.com/JuliaLogging/LoggingExtras.jl/issues/20
