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
        String jarFilePath = RASPAgent.class.getProtectionDomain().getCodeSource().getLocation().getPath();
        JarFile file = new JarFile(jarFilePath);
        inst.appendToBootstrapClassLoaderSearch(file);
    }

}
