package com.bionic.edu.bean;

import org.springframework.context.annotation.Scope;

import javax.inject.Named;
import java.io.Serializable;

@Named("msgs")
@Scope("session")
public class MessageBean implements Serializable {
    private static final long serialVersionUID = 8775004566511526824L;

    private final String nameRequired = "Customer's name field could not be empty";
    private final String emailRequired = "Customer's email field could not be empty";
    private final String passwordRequired = "Customer's password field could not be empty";
    private final String passwordRange = "Customer's password should not be less 8 symbols";
    private final String addressRequired = "Customer's address field could not be empty";

    public MessageBean() {
    }

    public String getNameRequired() {
        return nameRequired;
    }

    public String getEmailRequired() {
        return emailRequired;
    }

    public String getPasswordRequired() {
        return passwordRequired;
    }

    public String getPasswordRange() {
        return passwordRange;
    }

    public String getAddressRequired() {
        return addressRequired;
    }
}