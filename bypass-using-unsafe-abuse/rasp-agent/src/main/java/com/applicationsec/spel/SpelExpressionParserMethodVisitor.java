package com.applicationsec.spel;


import org.objectweb.asm.ClassVisitor;
import org.objectweb.asm.MethodVisitor;
import org.objectweb.asm.Opcodes;
import org.objectweb.asm.Type;
import org.objectweb.asm.commons.AdviceAdapter;
import org.objectweb.asm.commons.Method;

public class SpelExpressionParserMethodVisitor extends ClassVisitor {

    public SpelExpressionParserMethodVisitor(ClassVisitor visitor){
        super(Opcodes.ASM7, visitor);
    }

    @Override
    public MethodVisitor visitMethod(int methodAccess, String methodName, String methodDesc, String signature, String[] exceptions) {
        MethodVisitor methodVisitor = super.visitMethod(methodAccess, methodName, methodDesc, signature, exceptions);
        if ("doParseExpression".equals(methodName)) {
            return new SpelExpressionMethodVisitor(Opcodes.ASM5, methodVisitor, methodAccess, methodName, methodDesc);
        }
        return methodVisitor;
    }

    public static class SpelExpressionMethodVisitor extends AdviceAdapter {

        protected SpelExpressionMethodVisitor(int api, MethodVisitor methodVisitor, int methodAccess, String methodName, String methodDesc) {
            super(api, methodVisitor, methodAccess, methodName, methodDesc);
        }

        @Override
        protected void onMethodEnter() {
            Method mtd = new Method("check", "(Ljava/lang/String;)V");
            Type tp = Type.getType(SpelExpressionParserCheck.class);
            loadArg(0);
            invokeStatic(tp, mtd);
        }
    }

}

