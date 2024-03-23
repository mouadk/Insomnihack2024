This is a PoC where RASP is bypassed by abusing JNI and uploading a native library. 

- run [Main.kt](src%2Fmain%2Fjava%2Fcom%2Fapplicationsec%2FMain.kt) (with contrast enabled)
- run first [exploit-final.sh](exploit-final.sh) and see that we are blocked. 
- 
![blocked.png](images%2Fblocked.png)

- next, run the following scripts (please respect the order)
  - [exploit-1-3.sh](exploit-1-3.sh)
  - [exploit-2-3.sh](exploit-2-3.sh)
  - [exploit-3-3.sh](exploit-3-3.sh)
- finally rerun the exploit, and you will see that we have bypassed it: [exploit-final.sh](exploit-final.sh)

![bypassed.png](images%2Fbypassed.png)

**Defenses**
- RASP solutions should inspect http-headers (yes I know the header size is large, but it is the role of RASP to detect attacks and block them)
- RASP solutions should add probes and trace when a file is being written (eg. check if the input is tainted). 
- RASP solutions should also blacklist classes like java.nio.file.Files... 