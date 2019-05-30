package com.yuan.triangle;

import org.junit.jupiter.api.*;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintStream;

import static com.yuan.triangle.Triangle.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

class TriangleCaseTest {

    private static final Logger log = LoggerFactory.getLogger(TriangleCaseTest.class);

    private final InputStream systemIn = System.in;
    private final PrintStream systemOut = System.out;

    private ByteArrayInputStream testIn;
    private ByteArrayOutputStream testOut;

    private void provideInput(String data) {
        testIn = new ByteArrayInputStream(data.getBytes());
        System.setIn(testIn);
    }

    private String getOutput() {
        return testOut.toString();
    }


    @BeforeAll
    public static void init() {
        log.info("@BeforeAll: init()");
    }

    @AfterAll
    public static void done() {
        log.info("@AfterAll: done()");
    }

    @BeforeEach
    public void setUp() throws Exception {
        log.info("@BeforeEach: setUp()");
        testOut = new ByteArrayOutputStream();
        System.setOut(new PrintStream(testOut));
    }

    @AfterEach
    public void tearDown() throws Exception {
        log.info("@AfterEach: tearDown()");
        System.setIn(systemIn);
        System.setOut(systemOut);
    }

    @Test
    @Disabled
    @DisplayName("A disabled test")
    void testNotRun() {
        log.info("This test will not run (it is disabled, silly).");
    }

    @ParameterizedTest(name = "{0} {1} {2} {4}")
    @DisplayName("TestCase1: Judge Triangle")
    @CsvSource({
            "20, 30,  40,  0,   '能够构成三角形！\r\n'",
            "20, 30,  50,  -1,      '不能构成三角形！\r\n'",
    })
    void judgeTriangle(int a, int b, int c, int rc, String msg) {
        assertEquals(rc, JudgeTriangle(a, b, c),
                () -> a + " " + b + " " + c + " " + " should be " + rc);
        assertEquals(msg, getOutput());
    }

    @ParameterizedTest(name = "{0} {1} {2} {4}")
    @DisplayName("TestCase2: Judge DTriangle")
    @CsvSource({
            "30, 30,  30,  0,   '该三角形是等边三角形！\r\n'",
            "20, 30,  30,  0,      '该三角形是普通的等腰三角形！\r\n'",
            "20, 30,  40,  -1,      ''",

    })
    void judgeDTriangle(int a, int b, int c, int rc, String msg) {
        assertEquals(rc, JudgeDTriangle(a, b, c),
                () -> a + " " + b + " " + c + " " + " should be " + rc);
        assertEquals(msg, getOutput(),
                () -> getOutput() +" should be "+ msg);
    }

    @ParameterizedTest(name = "{0} {1} {2} {4}")
    @DisplayName("TestCase3: Judge RTriangle")
    @CsvSource({
            "30, 40,  50,  0,   '该三角形是直角三角形！\r\n'",
            "20, 30,  40,  -1,      ''",

    })
    void judgeRTriangle(int a, int b, int c, int rc, String msg) {
        assertEquals(rc, JudgeRTriangle(a, b, c),
                () -> a + " " + b + " " + c + " " + " should be " + rc);
        assertEquals(msg, getOutput(),
                () -> getOutput() +" should be "+ msg);
    }

    @ParameterizedTest(name = "{0} {1} {2} {4}")
    @DisplayName("TestCase4: main")
    @CsvSource({
            "'30 a 10',   '你输入的不是三个整数！\r\n'",
            "'30 10',   '你输入的不是三个整数！\r\n'",
            "'30 10 1.1',   '你输入的不是三个整数！\r\n'",

            "'30 20 201',   '你输入的三边不合法！\r\n'",
            "'20 30 40',   '能够构成三角形！\r\n该三角形是一般三角形！\r\n'",
            "'20 20 20',   '能够构成三角形！\r\n该三角形是等边三角形！\r\n'",
    })
    void main(String input, String msg) {
        final String prompt = "请输入三角形的三边: \r\n";

        provideInput(input);

        Triangle.main(new String[0]);

        assertEquals(prompt + msg, getOutput(),
                () -> getOutput() +" should be "+ msg);
    }
}