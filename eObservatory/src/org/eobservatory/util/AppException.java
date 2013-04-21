package org.eobservatory.util;

public class AppException extends RuntimeException {
    public AppException()
    {
        super();
    }
    
    public AppException(String message)
    {
        super(message);
    }
}