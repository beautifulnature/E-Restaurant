package com.bionic.edu.entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
public class Photo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotNull
    @Lob
    @Column(length = 512000)
    private byte[] content;

    public Photo() {
    }

    public Photo(byte[] content) {
        this.content = content;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public byte[] getContent() {
        return content;
    }

    public void setContent(byte[] content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "Photo{" +
                "id=" + id +
                '}';
    }
}
