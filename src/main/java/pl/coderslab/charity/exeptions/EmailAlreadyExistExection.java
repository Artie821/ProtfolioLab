package pl.coderslab.charity.exeptions;

public class EmailAlreadyExistExection extends Exception{

    public EmailAlreadyExistExection() {
        super();
    }


    public EmailAlreadyExistExection(String message) {
        super(message);
    }


    public EmailAlreadyExistExection(String message, Throwable cause) {
        super(message, cause);
    }
}
