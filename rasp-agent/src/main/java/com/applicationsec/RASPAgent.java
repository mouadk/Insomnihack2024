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
        String envVarName = "RASP_AGENT_PATH";
        String jarFilePath = System.getenv(envVarName);
        if (jarFilePath == null) {
            System.err.println("Environment variable '" + envVarName + "' is not set.");
            return;
        }
        JarFile file = new JarFile(jarFilePath);
        inst.appendToBootstrapClassLoaderSearch(file);
    }

}
