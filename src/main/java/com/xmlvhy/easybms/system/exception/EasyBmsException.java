package com.xmlvhy.easybms.system.exception;

/**
 * @ClassName EasyBmsException
 * @Description TODO
 * @Author 小莫
 * @Date 2019/07/04 22:46
 * @Version 1.0
 **/

public class EasyBmsException extends RuntimeException {

    public EasyBmsException() {
        super();
    }

    public EasyBmsException(String message) {
        super(message);
    }

    public EasyBmsException(String message, Throwable cause) {
        super(message, cause);
    }

    public EasyBmsException(Throwable cause) {
        super(cause);
    }

    protected EasyBmsException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
