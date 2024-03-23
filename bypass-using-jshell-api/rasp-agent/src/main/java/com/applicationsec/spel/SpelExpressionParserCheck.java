package com.applicationsec.spel;

import com.applicationsec.RASPSecurityException;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class SpelExpressionParserCheck {

    private static final String spelBlackList = "java.lang.Runtime";

    static public void check(String expressionString) {
        if(expressionString.contains(spelBlackList)){
            throw new RASPSecurityException("Spel expression injection attack detected :" + spelBlackList +" has been blocked by RASP");
        }
    }
}
