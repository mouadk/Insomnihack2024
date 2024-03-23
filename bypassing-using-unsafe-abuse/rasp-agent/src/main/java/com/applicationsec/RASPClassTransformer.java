package com.applicationsec;


import com.applicationsec.rce.ProcessImplMethodVisitor;
import com.applicationsec.spel.SpelExpressionParserMethodVisitor;
import org.objectweb.asm.ClassReader;
import org.objectweb.asm.ClassWriter;
import java.lang.instrument.ClassFileTransformer;
import java.security.ProtectionDomain;
import java.util.List;

public class RASPClassTransformer implements ClassFileTransformer {

        @Override
        public byte[] transform(ClassLoader loader, String className, Class<?> classBeingRedefined, ProtectionDomain protectionDomain, byte[] classfileBuffer) {
            if (!List.of("org/springframework/expression/spel/standard/SpelExpressionParser", "java/lang/ProcessImpl").contains(className)) {
                return null;
            }
            System.out.println("Class is being loaded by the JVM, it will transformed to include RASP probes : " + className);
            ClassReader reader = new ClassReader(classfileBuffer);
            ClassWriter writer = new ClassWriter(reader, ClassWriter.COMPUTE_FRAMES | ClassWriter.COMPUTE_MAXS);
            if(className.equals("java/lang/ProcessImpl")){
                reader.accept(new ProcessImplMethodVisitor(writer), ClassReader.EXPAND_FRAMES);
            } else {
                reader.accept(new SpelExpressionParserMethodVisitor(writer), ClassReader.EXPAND_FRAMES);
            }
            System.out.println("Probes inserted for " + className);
            return writer.toByteArray();
        }
}
