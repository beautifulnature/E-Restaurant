package com.bionic.edu.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Date;

@Entity
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    private String name;

    @NotNull
    @Column(unique = true)
    @Pattern(regexp = "^([^.@]+)(\\.[^.@]+)*@([^.@]+\\.)+([^.@]+)$", message = "{email.message}")
    private String email;

    @NotNull
    @Size(min = 8, message = "{password.message}")
    private String password;

    private Date birthDate;

    @NotNull
    private Date hireDate;

    @NotNull
    private boolean ready;

    @NotNull
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "photo_id")
    private Photo avatar;

    public Employee() {
    }

    public Employee(String name, String email, String password, Date birthDate, Date hireDate, boolean ready, Role role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.birthDate = birthDate;
        this.hireDate = hireDate;
        this.ready = ready;
        this.role = role;
    }

    public Employee(String name, String email, String password, Date birthDate, Date hireDate, boolean ready, Role role, Photo avatar) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.birthDate = birthDate;
        this.hireDate = hireDate;
        this.ready = ready;
        this.role = role;
        this.avatar = avatar;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }

    public boolean isReady() {
        return ready;
    }

    public void setReady(boolean ready) {
        this.ready = ready;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Photo getAvatar() {
        return avatar;
    }

    public void setAvatar(Photo avatar) {
        this.avatar = avatar;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", birthDate=" + birthDate +
                ", hireDate=" + hireDate +
                ", ready=" + ready +
                ", role=" + role +
                '}';
    }
}
