# Insomnihack2024

This repository houses demos for Insomnihack2024 conference: Hijacking the JVM and bypassing RASP [https://insomnihack.ch/talks-2024/#R7W9JV].  

## Rasp Agent
I've implemented a basic, naive RASP agent to demonstrate bypass techniques. 
Please do not regard it as a guide for implementing RASP. It was primarily used for demonstration purposes. 
Don't use it in production!.

## Bypass using Unsafe API 

Unsafe API is the most dangerous API in java. 
This PoC [bypass-using-unsafe-abuse](bypass-using-unsafe-abuse) shows how one can use it to bypass a RASP agent implementing guards in the constructor of sensitive classes.

## Bypass using Reflection Abuse

Some RASP agents does not take into account that an attacker could invoke private methods through reflection. And this can be used 
to bypass [bypass-using-reflection-abuse](bypass-using-reflection-abuse) hooks added by RASP. 

## Bypass using JNI/Library injection

An attacker can disable RASP by repatching [bypass-using-jni-injection](bypass-using-jni-injection) patched classes using JVMTI interface directly from native code. This can be done 
by first uploading a native library and then load it. 

## Bypass using Process injection

An attacker with enough capabilities can inject a shared library [bypass-using-process-injection](bypass-using-process-injection) in a java process and use JVMTI interface to remove the patch.

## Bypass using JVM Escape

An attacker can use gadgets to execute code outside the JVM, e.g. using Jshell API [bypass-using-jvm-escape](bypass-using-jvm-escape) which start a child local JVM and execute user code there. 



