package com.xmlvhy.easybms.system.utils.verifyCode;

import java.awt.*;
import java.io.OutputStream;

/**
 * @ClassName Captcha
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/28 13:45
 * @Version 1.0
 **/
public abstract class Captcha extends Randoms {
    /**
     * 设置字体 Verdana
     */
    protected Font font = new Font("Verdana", Font.ITALIC | Font.BOLD, 28);
    /**
     * 随机验证码长度
     */
    protected int len = 5;
    /**
     * 验证码显示宽度
     */
    protected int width = 150;
    /**
     * 验证码显示高度
     */
    protected int height = 40;
    /**
     * 随机字符串
     */
    private String chars = null;

    /**
     * 生成随机字符数组
     *
     * @return 字符数组
     */
    protected char[] alphas() {
        char[] cs = new char[len];
        for (int i = 0; i < len; i++) {
            cs[i] = alpha();
        }
        chars = new String(cs);
        return cs;
    }

    /**
     * 给定范围获得随机颜色
     *
     * @return Color 随机颜色
     */
    protected Color color(int fc, int bc) {
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + num(bc - fc);
        int g = fc + num(bc - fc);
        int b = fc + num(bc - fc);
        return new Color(r, g, b);
    }

    /**
     * 验证码输出,抽象方法，由子类实现
     *
     * @param os 输出流
     */
    public abstract void out(OutputStream os);

    /**
     * 获取随机字符串
     *
     * @return string
     */
    public String text() {
        return chars;
    }

    public Font getFont() {
        return font;
    }

    public void setFont(Font font) {
        this.font = font;
    }

    public int getLen() {
        return len;
    }

    public void setLen(int len) {
        this.len = len;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }
}
