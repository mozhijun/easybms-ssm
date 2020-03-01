package com.xmlvhy.easybms.system.common;

/**
 * @ClassName ParamsException
 * @Description TODO：自定义参数校验异常
 * @Author 小莫
 * @Date 2019/07/05 12:02
 * @Version 1.0
 **/
public class ParamsException extends RuntimeException {
    public ParamsException() {
        super();
    }

    public ParamsException(String message) {
        super(message);
    }

    public ParamsException(String message, Throwable cause) {
        super(message, cause);
    }

    public ParamsException(Throwable cause) {
        super(cause);
    }

    protected ParamsException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
