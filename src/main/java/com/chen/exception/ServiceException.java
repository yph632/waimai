package com.chen.exception;

public class ServiceException extends RuntimeException {
    private static final long serialVersionUID = -8507594230790325271L;

    public ServiceException(){}
    public ServiceException(String message) {
        super(message);
    }
    public ServiceException(Exception ex) {
        super(ex);
    }
    public ServiceException(String message,Exception ex) {
        super(message,ex);
    }
}
