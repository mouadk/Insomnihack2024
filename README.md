# Insomnihack2024

This repository holds demos for Insomnihack2024 conference, Hijacking the JVM and bypassing RASP.  

## rasp-agent
I've implemented a basic, naive RASP agent to demonstrate bypass techniques. 
Please do not regard it as a guide for implementing RASP. It was primarily used for demonstration purposes. 
Don't use it in production!.

## Bypass using Unsafe API 

Unsafe API is the most dangerous API in java. 
This PoC shows how one can use it to bypass a RASP agent implementing guards in the constructor of sensitive classes.

## Bypass using Reflection Abuse

Some RASP agents does not take into account that an attacker could invoke private methods through reflection. And this can be used 
to bypass hooks added by RASP. 

## Bypass using JNI/Library injection

An attacker can disable RASP by repatching the RASP patched classes using JVMTI interface directly from native code. This can be done 
by first uploading a native library and then load it. 

## Bypass using Process injection

An attacker with enough capabilities can inject a shared library in a java process and use JVMTI interface to remove the patch.

## Bypass using JVM Escape

An attacker can use gadgets to execute code outside the JVM, e.g. using Jshell API which start a child JVM and execute user code there. 



