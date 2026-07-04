package com.smartgrocery.model;

public class User {

    private int userId;
    private String name;
    private String email;
    private String password;
    private String role;

    public User(int userId, String name, String email,
                String password, String role) {
        this.userId   = userId;
        this.name     = name;
        this.email    = email;
        this.password = password;
        this.role     = role;
    }

    public int getUserId()      
        { return userId; }
    public String getName()     
        { return name; }
    public String getEmail()    
        { return email; }
    public String getPassword() 
        { return password; }
    public String getRole()     
        { return role; }

    public void setName(String name)         
        { this.name = name; }
    public void setEmail(String email)       
        { this.email = email; }
    public void setPassword(String password) 
        { this.password = password; }

    public void login()    
        { System.out.println("User logged in."); }
    public void logout()   
        { System.out.println("User logged out."); }
    public void register() 
        { System.out.println("User registered."); }
}