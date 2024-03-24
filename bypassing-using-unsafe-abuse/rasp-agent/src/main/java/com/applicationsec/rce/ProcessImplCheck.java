package com.applicationsec.rce;

import com.applicationsec.RASPSecurityException;

import java.util.Collections;
import java.util.List;

public class ProcessImplCheck {

    private static final List<String> blockedCommands = List.of("calc", "etc", "var", "opt", "apache", "bin", "passwd", "login", "cshrc", "profile", "ifconfig", "tcpdump", "chmod",
            "cron", "open", "sudo", "su", "rm", "wget", "sz", "kill", "apt-get", "find", "touch", "cat");

    static public void check(byte[] command){
        String command0 = new String(command, 0, command.length - 1);
        if(blockedCommands.contains(command0)){
            throw new RASPSecurityException("Commands :" + command0 +" has been blocked by RASP");
        }
    }

}
