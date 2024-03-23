package com.applicationsec;

import com.applicationsec.rce.ProcessImplMethodVisitor;
import org.objectweb.asm.ClassReader;
import org.objectweb.asm.ClassWriter;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;


// this is just to look at what the resulting bytecode in the JVM looks like
public class ProcessImplMain {
    public static void main(String[] args) throws IOException {
        ClassReader reader = new ClassReader("java/lang/ProcessImpl");
        ClassWriter writer = new ClassWriter(reader, ClassWriter.COMPUTE_FRAMES | ClassWriter.COMPUTE_MAXS);
        reader.accept(new ProcessImplMethodVisitor(writer), ClassReader.EXPAND_FRAMES);
        byte[] b = writer.toByteArray();
        File file = new File("ProcessBuilderTransformed.class");
        FileOutputStream outputStream = new FileOutputStream(file);
        outputStream.write(b);
        outputStream.close();
    }
}
