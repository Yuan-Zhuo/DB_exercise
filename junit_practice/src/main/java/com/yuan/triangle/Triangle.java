package com.yuan.triangle;

import java.util.Scanner;

public class Triangle {
    //判断是否能构成三角形
    public static int JudgeTriangle(int a, int b, int c) {
        if (a + b > c && a + c > b && b + c > a) {
            System.out.println("能够构成三角形！");
            return 0;
        } else {
            System.out.println("不能构成三角形！");
            return -1;
        }

    }

    //判断是否能构成等腰三角形
    public static int JudgeDTriangle(int a, int b, int c) {
        if (a == b || a == c || b == c) {
            if (a == b && a == c) {
                System.out.println("该三角形是等边三角形！");
            } else {
                System.out.println("该三角形是普通的等腰三角形！");
            }
            return 0;
        } else {
            return -1;
        }

    }

    //判断是否是直角三角形
    public static int JudgeRTriangle(int a, int b, int c) {
        int r1, r2, r3;
        r1 = a * a + b * b - c * c;
        r2 = a * a + c * c - b * b;
        r3 = b * b + c * c - a * a;
        if (r1 == 0 || r2 == 0 || r3 == 0) {
            System.out.println("该三角形是直角三角形！");
            return 0;
        } else {
            return -1;
        }

    }

    public static void main(String[] args) {
        int a, b, c;

        System.out.println("请输入三角形的三边: ");
        Scanner scanner = new Scanner(System.in);
        try {
            a = scanner.nextInt();
            b = scanner.nextInt();
            c = scanner.nextInt();
        } catch (Exception e) {
            System.out.println("你输入的不是三个整数！");
            return;
        }

        int rcDT = 0, rcRT = 0;

        //判断输入三边是否合法
        if (a < 0 || a > 200 || b < 0 || b > 200 || c < 0 || c > 200) {
            System.out.println("你输入的三边不合法！");
        }
        //判断是否能构成三角形
        else if (JudgeTriangle(a, b, c) == 0) {
            //判断是否是等腰或等边三角形
            rcDT = JudgeDTriangle(a, b, c);
            //判断是否是直角三角形
            rcRT = JudgeRTriangle(a, b, c);
        }

        //判断是否一般三角形
        if (rcDT == -1 && rcRT == -1)
            System.out.println("该三角形是一般三角形！");

    }
}
