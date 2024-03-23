package com.applicationsec;

import java.io.IOException;
import java.lang.instrument.Instrumentation;
import java.util.jar.JarFile;

public class RASPAgent {

    public static void premain(String args, Instrumentation instrumentation) throws IOException {
        initialize(instrumentation);
        instrumentation.addTransformer(new RASPClassTransformer());
    }

    public static void initialize(Instrumentation inst) throws IOException {
        var dir = System.getProperty("user.dir");
        JarFile file = new JarFile(dir + "/bypass-using-jshell-api/rasp-agent/target/rasp-agent-1.0.0-SNAPSHOT.jar");
        inst.appendToBootstrapClassLoaderSearch(file);
    }

}
